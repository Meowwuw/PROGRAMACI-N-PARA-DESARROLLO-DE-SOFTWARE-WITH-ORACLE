package com.canchavoley.backend.model;

public class Reserva {
    private int id;
    private int id_cliente;
    private int id_horario;
    private int id_cancha;
    private String fecha;

    public Reserva(int id, int id_cliente, int id_horario,
                   int id_cancha, String fecha){
        this.id=id;
        this.id_cliente=id_cliente;
        this.id_horario=id_horario;
        this.id_cancha=id_cancha;
        this.fecha=fecha;
    }

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id=id;
    }

    public int getId_cliente(){
        return id_cliente;
    }

    public void setId_cliente(int id_cliente){
        this.id_cliente=id_cliente;
    }

    public int getId_horario(){
        return id_horario;
    }

    public void setId_horario(int id_horario){
        this.id_horario=id_horario;
    }

    public int getId_cancha(){
        return id_cancha;
    }

    public void setId_cancha(int id_cancha){
        this.id_cancha=id_cancha;
    }

    public String getFecha(){
        return fecha;
    }

    public void setFecha(String fecha){
        this.fecha=fecha;
    }
}
