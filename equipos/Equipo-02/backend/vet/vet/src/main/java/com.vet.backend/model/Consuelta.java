
package com.vet.backend.model;

public class Consulta {

    private Long idConsulta;
    private String fechaCon;
    private Long idApoderado;
    private Long idVeterinario;

    public Consulta() {
    }

    public Consulta(Long idConsulta, String fechaCon, Long idApoderado, Long idVeterinario) {
        this.idConsulta = idConsulta;
        this.fechaCon = fechaCon;
        this.idApoderado = idApoderado;
        this.idVeterinario = idVeterinario;
    }

    public Long getIdConsulta() {
        return idConsulta;
    }

    public void setIdConsulta(Long idConsulta) {
        this.idConsulta = idConsulta;
    }

    public String getFechaCon() {
        return fechaCon;
    }

    public void setFechaCon(String fechaCon) {
        this.fechaCon = fechaCon;
    }

    public Long getIdApoderado() {
        return idApoderado;
    }

    public void setIdApoderado(Long idApoderado) {
        this.idApoderado = idApoderado;
    }

    public Long getIdVeterinario() {
        return idVeterinario;
    }

    public void setIdVeterinario(Long idVeterinario) {
        this.idVeterinario = idVeterinario;
    }
}
