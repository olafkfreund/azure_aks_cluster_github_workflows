import pytest
import requests
import time
from kubernetes import client, config

@pytest.fixture
def k8s_client():
    config.load_kube_config()
    return client.CoreV1Api()

@pytest.fixture
def k8s_networking_client():
    config.load_kube_config()
    return client.NetworkingV1Api()

@pytest.fixture
def ingress_host(k8s_networking_client):
    """Get ingress host/IP for the service"""
    max_retries = 5
    retry_delay = 10
    
    for attempt in range(max_retries):
        try:
            ingress = k8s_networking_client.read_namespaced_ingress(
                name="dotnet-ingress",
                namespace="default"
            )
            
            # Check for load balancer status
            if ingress.status.load_balancer.ingress:
                # Return first available hostname or IP
                return (ingress.status.load_balancer.ingress[0].hostname or 
                       ingress.status.load_balancer.ingress[0].ip)
                
        except Exception as e:
            if attempt == max_retries - 1:
                raise Exception(f"Failed to get ingress after {max_retries} attempts: {str(e)}")
            time.sleep(retry_delay)

@pytest.fixture
def service_url(ingress_host):
    """Build service URL from ingress host"""
    return f"https://{ingress_host}"

def test_service_health(service_url, k8s_client):
    """Test the application health endpoint and service availability"""
    max_retries = 5
    retry_delay = 10
    
    for attempt in range(max_retries):
        try:
            # Test health endpoint
            health_response = requests.get(
                f"{service_url}/health",
                timeout=5,
                verify=False
            )
            assert health_response.status_code == 200

            # Verify service and endpoints
            services = k8s_client.list_namespaced_service(namespace="default")
            service_found = any(
                svc.metadata.name == "aspnet-core-service" 
                for svc in services.items
            )
            assert service_found

            endpoints = k8s_client.list_namespaced_endpoints(
                namespace="default",
                field_selector=f"metadata.name=aspnet-core-service"
            )
            assert len(endpoints.items[0].subsets) > 0
            
            return
            
        except (requests.RequestException, AssertionError) as e:
            if attempt == max_retries - 1:
                raise Exception(f"Health check failed after {max_retries} attempts: {str(e)}")
            time.sleep(retry_delay)