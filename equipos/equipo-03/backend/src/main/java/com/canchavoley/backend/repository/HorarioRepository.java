package com.canchavoley.backend.repository;

<<<<<<< Updated upstream
public interface HorarioRepository {
}
=======
import com.canchavoley.backend.model.Horario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HorarioRepository extends JpaRepository<Horario, Long> {

}
>>>>>>> Stashed changes
