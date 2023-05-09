package com.bongsick.bongsick.respository;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.CompanySave;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.domain.ThemeSave;

import java.util.List;

public interface Repository {
    List<Theme> getThemes();

    List<Company> getCompanies();

    Company getCompany(String companyId);

    Theme getThemeDetail(String themeId);

    List<Theme> getThemesByCompany(String companyId);

    String saveTheme(ThemeSave theme);

    String saveCompany(CompanySave company);

    void deleteThemes();

    List<String> getAllCompanies();

    void changeAllCompanyName(String companyName, String newCompanyName);
}