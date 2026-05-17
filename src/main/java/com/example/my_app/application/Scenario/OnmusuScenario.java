package com.example.my_app.application.Scenario;

import com.example.my_app.domain.service.OnmusuService;
import com.example.my_app.application.converter.OnmusuConverter;
import com.example.my_app.application.dto.OnmusuResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OnmusuScenario {

    private final OnmusuService onmusuService;
    private final OnmusuConverter onmusuConverter;

    @Transactional(readOnly = true)
    public List<OnmusuResponse> getAll() {
        return onmusuConverter.toResponseList(onmusuService.getAll());
    }

}
