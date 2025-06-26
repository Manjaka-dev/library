package itu.project.library.repository;

import itu.project.library.entity.DureePret;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DureePretRepository extends JpaRepository<DureePret, Integer> {
    
    @Query("SELECT dp FROM DureePret dp WHERE dp.profil.idProfil = :profilId")
    List<DureePret> findByProfilId(@Param("profilId") Integer profilId);
}
