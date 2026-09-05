package com.Vet.backend.model;

public class Veterinario {
    private Long idVeterinario;
    private String nombre;
    private String especialidad;
    private String telefono;

    public Veterinario(){
    }
    public Veterinario(Long idVeterinario, String nombre, String especialidad, String telefono){
        this.idVeterinario = idVeterinario;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
    }
    public Long getIdVeterinario(){
        return idVeterinario;
    }
    public String getNombre(){
        return nombre;
    }
    public String getEspecialidad(){
        return especialidad;
    }
    public String getTelefono(){
        return telefono;
    }
}
