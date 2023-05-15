package com.bongsick.bongsick.respository;


import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.CompanySave;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.domain.ThemeSave;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ExecutionException;

@Repository
@Slf4j
public class FirebaseRepository implements com.bongsick.bongsick.respository.Repository {

    private static final String THEMES_COLLECTION = "themes";
    private static final String COMPANIES_COLLECTION = "companies";
    private final Firestore db;

    @Autowired
    public FirebaseRepository(Firestore db) {
        this.db = db;
    }

    @Override
    public List<Theme> getThemes() {
        List<Theme> themes = new ArrayList<>();
        ApiFuture<QuerySnapshot> future = db.collection(THEMES_COLLECTION).get();
        try {
            List<QueryDocumentSnapshot> documents = future.get().getDocuments();
            for (QueryDocumentSnapshot document : documents) {
                Theme theme = document.toObject(Theme.class);
                theme.setId(document.getId());
                themes.add(theme);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return themes;
    }

    @Override
    public List<Company> getCompanies() {
        List<Company> companies = new ArrayList<>();
        ApiFuture<QuerySnapshot> future = db.collection(COMPANIES_COLLECTION).get();
        try {
            List<QueryDocumentSnapshot> documents = future.get().getDocuments();
            for (QueryDocumentSnapshot document : documents) {
                Company company = document.toObject(Company.class);
                company.setId(document.getId());
                companies.add(company);
            }
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
        return companies;
    }

    @Override
    public Company getCompany(String companyId) {
        Company company;
        ApiFuture<DocumentSnapshot> future = db.collection(COMPANIES_COLLECTION).document(companyId).get();
        try {
            company = future.get().toObject(Company.class);
            assert company != null;
            company.setId(future.get().getId());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return company;
    }

    @Override
    public Theme getThemeDetail(String themeId) {
        ApiFuture<DocumentSnapshot> future = db.collection(THEMES_COLLECTION).document(themeId).get();
        try {
            Theme theme = future.get().toObject(Theme.class);
            assert theme != null;
            theme.setId(future.get().getId());
            return theme;
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Theme> getThemesByCompany(String companyId) {
        List<Theme> themes = new ArrayList<>();
        ApiFuture<QuerySnapshot> future = db.collection(THEMES_COLLECTION)
                .whereEqualTo("companyId", companyId)
                .get();
        List<QueryDocumentSnapshot> documents;
        try {
            documents = future.get().getDocuments();
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
        for (QueryDocumentSnapshot document : documents) {
            Theme theme = document.toObject(Theme.class);
            theme.setId(document.getId());
            themes.add(theme);
        }
        return themes;
    }

    @Override
    public String saveTheme(ThemeSave theme) {
        // TODO - Add Exception When it already existed

        ApiFuture<DocumentReference> add = db.collection(THEMES_COLLECTION).add(theme);
        try {
            return add.get().getId();
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String saveCompany(Company company) {
        // TODO - Add Exception When it already existed
        ApiFuture<WriteResult> add = db.collection(COMPANIES_COLLECTION)
                .document(company.getId()).set(new CompanySave(company));

        try {
            String s = add.get().toString();
            return "["+company.getId()+"]"+company.getName()+" has Saved";
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteThemes() {
        Iterable<DocumentReference> documentReferences = db.collection(THEMES_COLLECTION).listDocuments();
        for (DocumentReference documentReference : documentReferences) {
            documentReference.delete();
        }

    }

    @Override
    public List<String> getAllCompaniesName() {
        Iterable<DocumentReference> docRefs = db.collection(THEMES_COLLECTION).listDocuments();

        Set<String> companies = new HashSet<>();

        for (DocumentReference docRef : docRefs) {
            ApiFuture<DocumentSnapshot> future = docRef.get();
            DocumentSnapshot document = null;
            try {
                document = future.get();
            } catch (InterruptedException | ExecutionException e) {
                throw new RuntimeException(e);
            }

            Theme theme = document.toObject(Theme.class);
            assert theme != null;
            companies.addAll(theme.getCompanies());
        }

        return companies.stream().toList();
    }

    @Override
    public void changeAllCompanyName(String companyName, String newCompanyName) {
        // TODO
    }


}