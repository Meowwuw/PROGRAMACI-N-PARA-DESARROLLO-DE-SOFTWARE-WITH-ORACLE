package com.Vet.backend.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "razas")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Raza {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_raza")
    private Integer idRaza;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_especie", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Especie especie;

    @Column(name = "nombre_raza", nullable = false, length = 100)
    private String nombreRaza;
}
