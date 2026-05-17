package com.example.my_app.application.converter;

import com.example.my_app.domain.entity.Onmusu;
import com.example.my_app.application.dto.OnmusuResponse;

import java.util.List;

@org.mapstruct.Mapper(componentModel = "spring")
public interface OnmusuConverter {

    OnmusuResponse toResponse(Onmusu onmusu);
    List<OnmusuResponse> toResponseList(List<Onmusu> onmusuList);

}
