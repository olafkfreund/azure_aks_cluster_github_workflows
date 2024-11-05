import pytest
import requests
import time
from kubernetes import client, config

class TestDeployment:
    @pytest.fixture(scope="session")
    def service_url(self):
        config.load_kube_config()
        v1 = client.CoreV1Api()
        
        # Wait for service to get external IP
        retries = 30
        while retries > 0:
            service = v1.read_namespaced_service(
                name="aspnet-core-service",
                namespace="default"
            )
            if service.status.load_balancer.ingress:
                return f"http://{service.status.load_balancer.ingress[0].ip}"
            time.sleep(10)
            retries -= 1
        raise Exception("Service external IP not found")

    def test_deployment_replicas(self):
        apps_v1 = client.AppsV1Api()
        deployment = apps_v1.read_namespaced_deployment(
            name="aspnet-core-deployment",
            namespace="default"
        )
        assert deployment.status.replicas == deployment.status.ready_replicas

    def test_service_health(self, service_url):
        response = requests.get(f"{service_url}/health")
        assert response.status_code == 200

    def test_ingress_routing(self):
        networking_v1 = client.NetworkingV1Api()
        ingress = networking_v1.read_namespaced_ingress(
            name="app-ingress",
            namespace="default"
        )
        assert any(path.path == "/api(/|$)(.*)" for path in ingress.spec.rules[0].http.paths)
        assert any(path.path == "/(.*)" for path in ingress.spec.rules[0].http.paths)