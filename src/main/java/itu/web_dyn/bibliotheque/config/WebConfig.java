package itu.web_dyn.bibliotheque.config;

import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ServletComponentScan
public class WebConfig {
    // Cette configuration active l'annotation @WebFilter
}
