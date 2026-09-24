package com.Vet.backend.service;

import com.Vet.backend.model.Dueno;
import com.Vet.backend.repository.DuenoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DuenoService {

    @Autowired
    private DuenoRepository duenoRepository;

    public List<Dueno> findAll() {
        return duenoRepository.findAll();
    }

    public Optional<Dueno> findById(Integer id) {
        return duenoRepository.findById(id);
    }

    public Dueno save(Dueno dueno) {
        return duenoRepository.save(dueno);
    }

    public void deleteById(Integer id) {
        duenoRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return duenoRepository.existsById(id);
    }
}
