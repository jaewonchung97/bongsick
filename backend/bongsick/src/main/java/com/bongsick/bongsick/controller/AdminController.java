package com.bongsick.bongsick.controller;

import com.bongsick.bongsick.service.CrawlingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

    private final CrawlingService crawlingService;

    @Autowired
    public AdminController(CrawlingService crawlingService) {
        this.crawlingService = crawlingService;
    }

//    @RequestMapping("/admin")
    public String saveThemes(){
        crawlingService.saveXPhobiaThemes();
        return "done";
    }
}
