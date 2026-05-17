package com.example.my_app.application;

import com.example.my_app.infrastructure.mapper.OnmusuMapper;
import com.example.my_app.infrastructure.entity.Onmusu;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OnmusuService {

    private final OnmusuMapper onmusuMapper;

    @Transactional(readOnly = true)
    public List<Onmusu> getAllMarker() {
        return onmusuMapper.selectAll();
    }

}
