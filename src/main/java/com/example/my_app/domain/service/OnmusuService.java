package com.example.my_app.domain.service;

import com.example.my_app.domain.entity.Onmusu;
import com.example.my_app.infrastructure.mapper.OnmusuMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OnmusuService {

    private final OnmusuMapper onmusuMapper;

    public List<Onmusu> getAll() {
        return onmusuMapper.selectAll();
    }

}
