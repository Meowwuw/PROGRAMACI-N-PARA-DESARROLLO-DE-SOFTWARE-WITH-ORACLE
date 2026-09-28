package com.VoleyPlay.backend.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "reserva", schema = "voley_playa")
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reserva")
    private Long id;

    @Column(name = "id_cliente")
    private Long idCliente;

    @Column(name = "id_cancha")
    private Long idCancha;

    @Column(name = "id_horario")
    private Long idHorario;

    @Column(name = "fecha_reserva")
    private LocalDate fechaReserva;

    private String estado;

    private double total;

    public Reserva() {
    }

    public Reserva(Long id, Long idCliente, Long idCancha, Long idHorario, LocalDate fechaReserva, String estado, double total) {
        this.id = id;
        this.idCliente = idCliente;
        this.idCancha = idCancha;
        this.idHorario = idHorario;
        this.fechaReserva = fechaReserva;
        this.estado = estado;
        this.total = total;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Long idCliente) {
        this.idCliente = idCliente;
    }

    public Long getIdCancha() {
        return idCancha;
    }

    public void setIdCancha(Long idCancha) {
        this.idCancha = idCancha;
    }

    public Long getIdHorario() {
        return idHorario;
    }

    public void setIdHorario(Long idHorario) {
        this.idHorario = idHorario;
    }

    public LocalDate getFechaReserva() {
        return fechaReserva;
    }

    public void setFechaReserva(LocalDate fechaReserva) {
        this.fechaReserva = fechaReserva;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}