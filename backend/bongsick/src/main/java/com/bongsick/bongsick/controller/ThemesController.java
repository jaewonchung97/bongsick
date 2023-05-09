package com.bongsick.bongsick.controller;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.service.ThemeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping
public class ThemesController {

    private final ThemeService themeService;

    @Autowired
    public ThemesController(ThemeService themeService) {
        this.themeService = themeService;
    }

    @GetMapping("/themes")
    public List<Theme> getThemes() {
        return themeService.getThemes();
    }

    @GetMapping("/theme/{themeId}")
    public Theme getThemeDetail(
            @PathVariable String themeId
    ) {
        return themeService.getThemeDetail(themeId);
    }

    @GetMapping("/companies")
    public List<Company> getCompanies() {
        return themeService.getCompanies();
    }


    @GetMapping("/company/{companyId}")
    public Company getCompany(
            @PathVariable("companyId") String companyId
    ) {
        return themeService.getCompany(companyId);
    }

    @GetMapping("/company/{companyId}/themes")
    public List<Theme> getThemesByCompany(
            @PathVariable String companyId
    ) {
        return themeService.getThemesByCompany(companyId);
    }
}
