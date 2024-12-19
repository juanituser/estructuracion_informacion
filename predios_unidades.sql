with predios_con_unidades as (
    select 
        numero_predial, 
        cast(habitaciones_1 as numeric) as habitaciones, 
        cast(banos_1 as numeric) as banios, 
        cast(locales_1 as numeric) as locales, 
        cast(pisos_1 as numeric) as pisos, 
        cast(uso_1 as numeric) as uso, 
        cast(puntaje_1 as numeric) as puntaje, 
        cast(tipificacion_1 as numeric) as tipificacion,
        cast(area_construida_1 as numeric) as area_construida
    from insumos.r2 
    where cast(area_construida_1 as numeric) != 0
    union 
    select 
        numero_predial, 
        cast(habitaciones_2 as numeric) as habitaciones, 
        cast(banos_2 as numeric) as banios, 
        cast(locales_2 as numeric) as locales, 
        cast(pisos_2 as numeric) as pisos, 
        cast(uso_2 as numeric) as uso, 
        cast(puntaje_2 as numeric) as puntaje, 
        cast(tipificacion_2 as numeric) as tipificacion,
        cast(area_construida_2 as numeric) as area_construida
    from insumos.r2 
    where cast(area_construida_2 as numeric) != 0
    union 
    select 
        numero_predial, 
        cast(habitaciones_3 as numeric) as habitaciones, 
        cast(banos_3 as numeric) as banios, 
        cast(locales_3 as numeric) as locales, 
        cast(pisos_3 as numeric) as pisos, 
        cast(uso_3 as numeric) as uso, 
        cast(puntaje_3 as numeric) as puntaje, 
        cast(tipificacion_3 as numeric) as tipificacion,
        cast(area_construida_3 as numeric) as area_construida
    from insumos.r2 
    where cast(area_construida_3 as numeric) != 0
)
select 
    pu.*, 
    du.dominio_modelo_ladm, 
    case 
    	when du.clase='Anexos'
    	then 'No convencional'
    	else 'Convencional'
    end as clase
into resultados.unidades_construccion
from predios_con_unidades pu 
join insumos.dominio_usos du 
on pu.uso = cast(du.codigo as numeric);


select * from resultados.unidades_construccion;

------------------------------------------------------
--- Número de predios con unidades de construcción ---
------------------------------------------------------

select count(distinct numero_predial) from resultados.unidades_construccion;

----------------------------------------------
--- Frecuencia de unidades de construcción ---
----------------------------------------------

select count(*) as predios, cantidad_unidades
from (select numero_predial, count(*) as cantidad_unidades 
	from resultados.unidades_construccion
	group by numero_predial) as foo
group by cantidad_unidades;

--------------------------
--- Predios con anexos ---
--------------------------

select count(distinct numero_predial)
from resultados.unidades_construccion
where clase='No convencional';


