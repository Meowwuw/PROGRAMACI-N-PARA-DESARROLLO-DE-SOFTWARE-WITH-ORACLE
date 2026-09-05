package com.canchavoley.backend.model;

public class Pago {
    private Long id;
    private Long id_reserva;
    private Double total;

    public Pago(Long id, Long id_reserva, Double total){
        this.id=id;
        this.id_reserva=id_reserva;
        this.total=total;
    }

    public Long getId(){ return id;}

    public Long getIdReserva(){ return id_reserva;}

    public Double getTotal(){ return total;}
}
