package com.example.my_app.presentation.converter;

import com.example.my_app.infrastructure.entity.Onmusu;
import com.example.my_app.presentation.dto.OnmusuResponse;

import java.util.List;

@org.mapstruct.Mapper(componentModel = "spring")
public interface OnmusuConverter {

    OnmusuResponse toResponse(Onmusu onmusu);
    List<OnmusuResponse> toResponseList(List<Onmusu> onmusuList);

}
