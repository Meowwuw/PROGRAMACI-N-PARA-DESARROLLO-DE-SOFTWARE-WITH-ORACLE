package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.service.ClienteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/clientes")
public class clienteController {
    private final ClienteService clienteService;

    public clienteController(ClienteService clienteService) {
        this.clienteService = clienteService;
    }

    // ---- GET (5) ----
    @GetMapping
    public List<Cliente> listar() {
        return clienteService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Cliente> buscarPorId(@PathVariable Long id) {
        Cliente cliente = clienteService.buscarPorId(id);
        return cliente != null ? ResponseEntity.ok(cliente) : ResponseEntity.notFound().build();
    }

    @GetMapping("/dni/{dni}")
    public ResponseEntity<Cliente> buscarPorDni(@PathVariable String dni) {
        Cliente cliente = clienteService.buscarPorDni(dni);
        return cliente != null ? ResponseEntity.ok(cliente) : ResponseEntity.notFound().build();
    }

    @GetMapping("/apellido/{apellido}")
    public List<Cliente> buscarPorApellido(@PathVariable String apellido) {
        return clienteService.buscarPorApellido(apellido);
    }

    @GetMapping("/count")
    public long contar() {
        return clienteService.contar();
    }

    // ---- POST (2) ----
    @PostMapping
    public Cliente guardar(@RequestBody Cliente cliente) {
        return clienteService.guardar(cliente);
    }

    @PostMapping("/lote")
    public List<Cliente> guardarVarios(@RequestBody List<Cliente> clientes) {
        return clienteService.guardarVarios(clientes);
    }

    // ---- PUT (2) ----
    @PutMapping("/{id}")
    public ResponseEntity<Cliente> actualizar(@PathVariable Long id, @RequestBody Cliente cliente) {
        Cliente actualizado = clienteService.actualizar(id, cliente);
        return actualizado != null ? ResponseEntity.ok(actualizado) : ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}/telefono")
    public ResponseEntity<Cliente> actualizarTelefono(@PathVariable Long id, @RequestBody Integer telefono) {
        Cliente actualizado = clienteService.actualizarTelefono(id, telefono);
        return actualizado != null ? ResponseEntity.ok(actualizado) : ResponseEntity.notFound().build();
    }

    // ---- DELETE (2) ----
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        return clienteService.eliminar(id) ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/dni/{dni}")
    public ResponseEntity<Void> eliminarPorDni(@PathVariable String dni) {
        clienteService.eliminarPorDni(dni);
        return ResponseEntity.noContent().build();
    }
}
