package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.service.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/clientes")
@CrossOrigin(origins = "*")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;

    // ==========================================
    // 5 ENDPOINTS GET
    // ==========================================

    // GET 1: Listar todos los clientes
    @GetMapping
    public List<Cliente> listarTodos() {
        return clienteService.obtenerTodos();
    }

    // GET 2: Buscar cliente por ID
    @GetMapping("/{id}")
    public ResponseEntity<Cliente> buscarPorId(@PathVariable Long id) {
        return clienteService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 3: Buscar cliente por DNI
    @GetMapping("/dni/{dni}")
    public ResponseEntity<Cliente> buscarPorDni(@PathVariable String dni) {
        return clienteService.obtenerPorDni(dni)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 4: Verificar existencia por DNI
    @GetMapping("/existe/{dni}")
    public ResponseEntity<Boolean> existePorDni(@PathVariable String dni) {
        return ResponseEntity.ok(clienteService.existePorDni(dni));
    }

    // GET 5: Contar total de clientes registrados
    @GetMapping("/conteo")
    public ResponseEntity<Long> contarClientes() {
        return ResponseEntity.ok(clienteService.contarTodos());
    }

    // ==========================================
    // 2 ENDPOINTS POST
    // ==========================================

    // POST 1: Registrar un cliente individual
    @PostMapping
    public ResponseEntity<Cliente> crearCliente(@RequestBody Cliente cliente) {
        return new ResponseEntity<>(clienteService.guardar(cliente), HttpStatus.CREATED);
    }

    // POST 2: Registrar varios clientes en lote
    @PostMapping("/lote")
    public ResponseEntity<List<Cliente>> crearClientesEnLote(@RequestBody List<Cliente> clientes) {
        return new ResponseEntity<>(clienteService.guardarVarios(clientes), HttpStatus.CREATED);
    }

    // ==========================================
    // 2 ENDPOINTS PUT
    // ==========================================

    // PUT 1: Actualización completa del cliente por ID
    @PutMapping("/{id}")
    public ResponseEntity<Cliente> actualizarCliente(@PathVariable Long id, @RequestBody Cliente cliente) {
        return ResponseEntity.ok(clienteService.actualizar(id, cliente));
    }

    // PUT 2: Actualizar únicamente el teléfono del cliente
    @PutMapping("/{id}/telefono")
    public ResponseEntity<Cliente> actualizarTelefono(@PathVariable Long id, @RequestParam String nuevoTelefono) {
        return ResponseEntity.ok(clienteService.actualizarTelefono(id, nuevoTelefono));
    }

    // ==========================================
    // 2 ENDPOINTS DELETE
    // ==========================================

    // DELETE 1: Eliminar cliente por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPorId(@PathVariable Long id) {
        clienteService.eliminarPorId(id);
        return ResponseEntity.noContent().build();
    }

    // DELETE 2: Eliminar cliente por DNI
    @DeleteMapping("/dni/{dni}")
    public ResponseEntity<Void> eliminarPorDni(@PathVariable String dni) {
        clienteService.eliminarPorDni(dni);
        return ResponseEntity.noContent().build();
    }
}