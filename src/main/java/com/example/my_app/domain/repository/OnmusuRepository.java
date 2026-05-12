package com.example.my_app.domain.repository;


import com.example.my_app.infrastructure.entity.Onmusu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OnmusuRepository {

    List<Onmusu> selectAll();

}
