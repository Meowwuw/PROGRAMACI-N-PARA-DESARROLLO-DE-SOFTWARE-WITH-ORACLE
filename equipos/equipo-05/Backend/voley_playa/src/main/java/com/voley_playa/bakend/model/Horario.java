package com.voley_playa.bakend.model;



import jakarta.persistence.*;

import javax.xml.validation.Schema;
import java.math.BigDecimal;

import java.time.LocalTime;



@Entity

@Table(name = "Horario", schema ="voley_playa")

public class Horario {



    @Id

    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Integer id_horario;



    private LocalTime hora_inicio;

    private LocalTime hora_fin;

    private BigDecimal precio;



    public Integer getId_horario() {

        return id_horario;

    }



    public void setId_horario(Integer id_horario) {

        this.id_horario = id_horario;

    }



    public LocalTime getHora_inicio() {

        return hora_inicio;

    }



    public void setHora_inicio(LocalTime hora_inicio) {

        this.hora_inicio = hora_inicio;

    }



    public LocalTime getHora_fin() {

        return hora_fin;

    }



    public void setHora_fin(LocalTime hora_fin) {

        this.hora_fin = hora_fin;

    }



    public BigDecimal getPrecio() {

        return precio;

    }



    public void setPrecio(BigDecimal precio) {

        this.precio = precio;

    }

}

