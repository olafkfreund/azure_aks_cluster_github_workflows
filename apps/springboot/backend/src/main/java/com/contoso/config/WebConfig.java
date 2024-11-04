// backend/src/main/java/com/contoso/config/WebConfig.java
package com.contoso.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebConfig implements WebMvcConfigurer {

  @Override
  public void addCorsMappings(CorsRegistry registry) {
    registry.addMapping("/**")
      .allowedOrigins("http://localhost:3000")
      .allowedMethods("*")
      .allowedHeaders("*");
  }
}