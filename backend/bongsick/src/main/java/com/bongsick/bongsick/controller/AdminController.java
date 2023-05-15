package com.bongsick.bongsick.controller;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.service.CrawlingService;
import com.bongsick.bongsick.service.ThemeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class AdminController {

    private final CrawlingService crawlingService;
    private final ThemeService themeService;


    @Autowired
    public AdminController(CrawlingService crawlingService, ThemeService themeService) {
        this.crawlingService = crawlingService;
        this.themeService = themeService;
    }

//    @RequestMapping("/admin")
    public String saveThemes(){
        crawlingService.saveXPhobiaThemes();
        return "done";
    }

    @GetMapping(value = "/savecompany")
    @ResponseBody
    public String saveCompany(){
        List<String> companies = themeService.getAllCompaniesName();
        for (String companyName : companies) {
            crawlingService.saveCompany(companyName);
        }
        return "done";
    }
}
