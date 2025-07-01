package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.QuotaTypePret;
import itu.web_dyn.bibliotheque.entities.QuotaTypePretId;

import java.util.List;

@Repository
public interface QuotaTypePretRepository extends JpaRepository<QuotaTypePret, QuotaTypePretId> {
    
    @Query("SELECT qtp FROM QuotaTypePret qtp WHERE qtp.profil.idProfil = :profilId")
    List<QuotaTypePret> findByProfilId(@Param("profilId") Integer profilId);
    
    @Query("SELECT qtp FROM QuotaTypePret qtp WHERE qtp.typePret.idTypePret = :typePretId")
    List<QuotaTypePret> findByTypePretId(@Param("typePretId") Integer typePretId);
}
