package com.Vet.backend.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "especies")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Especie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_especie")
    private Integer idEspecie;

    @Column(name = "nombre_especie", nullable = false, length = 100)
    private String nombreEspecie;
}
