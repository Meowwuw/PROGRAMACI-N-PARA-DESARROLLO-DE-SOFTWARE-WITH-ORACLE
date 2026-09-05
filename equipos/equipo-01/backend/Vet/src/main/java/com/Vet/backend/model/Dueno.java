package com.Vet.backend.model;

public class Dueno {
    private Long idDueno;
    private String nombre;
    private String telefono;
    private String direccion;

    public Dueno(){
    }
    public Dueno(Long idDueno, String nombre, String telefono, String direccion){
        this.idDueno = idDueno;
        this.nombre = nombre;
        this.telefono = telefono;
        this.direccion = direccion;
    }
    public Long getIdDueno(){
        return idDueno;
    }
    public String getNombre(){
        return nombre;
    }
    public String getTelefono(){
        return telefono;
    }
    public String getDireccion(){
        return direccion;
    }
}
