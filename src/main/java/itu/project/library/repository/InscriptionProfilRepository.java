package itu.project.library.repository;

import itu.project.library.entity.InscriptionProfil;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface InscriptionProfilRepository extends JpaRepository<InscriptionProfil, Integer> {
    
    @Query("SELECT ip FROM InscriptionProfil ip WHERE ip.profil.idProfil = :profilId")
    List<InscriptionProfil> findByProfilId(@Param("profilId") Integer profilId);
}
