package com.four.brothers.runtou.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Configuration
public class SwaggerConfig {

  @Bean
  public OpenAPI api() {
    Info info = new Info()
      .title("Run-To-U")
      .version("V1.0")
      .contact(new Contact()
              .name("Web Site")
              .url("http://3.38.254.41"))
      .license(new License()
              .name("Apache License Version 2.0")
              .url("http://www.apache.org/license/LICENSE-2.0"));

    SecurityScheme auth = new SecurityScheme()
      .type(SecurityScheme.Type.APIKEY).in(SecurityScheme.In.COOKIE).name("JSESSIONID");
    SecurityRequirement securityRequirement = new SecurityRequirement().addList("basicAuth");

    return new OpenAPI()
      .components(new Components().addSecuritySchemes("basicAuth", auth))
      .addSecurityItem(securityRequirement)
      .info(info);
  }

}
