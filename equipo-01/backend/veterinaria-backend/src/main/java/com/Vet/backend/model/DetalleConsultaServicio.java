package com.Vet.backend.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "detalle_consulta_servicio")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DetalleConsultaServicio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detalle")
    private Integer idDetalle;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_consulta", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Consulta consulta;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_servicio", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Servicio servicio;

    @Column(name = "observaciones", length = 300)
    private String observaciones;
}
