package com.VoleyPlay.backend.model;

public class Reserva {

    private Long id;
    private Long idCliente;
    private Long idCancha;
    private Long idHorario;
    private String fechaReserva;
    private String estado;
    private double total;

    public Reserva(Long id, Long idCliente, Long idCancha, Long idHorario, String fechaReserva, String estado, double total) {
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

    public Long getIdCliente() {
        return idCliente;
    }

    public Long getIdCancha() {
        return idCancha;
    }

    public Long getIdHorario() {
        return idHorario;
    }

    public String getFechaReserva() {
        return fechaReserva;
    }

    public String getEstado() {
        return estado;
    }

    public double getTotal() {
        return total;
    }
}