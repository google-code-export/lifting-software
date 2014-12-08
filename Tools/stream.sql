select
  co.id_compet||'_'||loc.id_stream as ID
  , trim(trim(co.name)) as cname
  ,Trim(co.town) ||', '||
  case
    when EXTRACT(month from co.date_begin)=EXTRACT(month from co.date_end) then
     EXTRACT(day from co.date_begin) ||' - '||EXTRACT(day from co.date_end)||'.'||EXTRACT(month from co.date_begin) ||'.'||EXTRACT(year from co.date_end)
    else
     EXTRACT(day from co.date_begin)||'.'||EXTRACT(month from co.date_begin) ||' - '||EXTRACT(day from co.date_end)||'.'||EXTRACT(month from co.date_begin) ||'.'||EXTRACT(year from co.date_end)
  end ||' ã.' as cdescr


  , cast(cutfio2(l.name) as varchar(254)) as "Name"
  , t.name as "Team"
  , cast( EXTRACT(year from l.dat_bith) as varchar(4))||'/ '||w.self_weight||'/ '||loc.zr as "BY/BW/Lot"
  , cast(w.coef as numeric(4,4)) as "G.Coef"
  , ac.name as agecl
  , wc.name as wc
  , r.name rname
  , r.kind rkind
  , le.oc1   as oc1
  , le.oc2   as oc2
  , le.oc3   as oc3
  , le.oc10  as oc4
  , le.oc4   as oc5
  , le.oc5   as oc6
  , le.oc6   as oc7
  , le.oc11  as oc8
  , le.oc7   as oc9
  , le.oc8   as oc10
  , le.oc9   as oc11
  , le.oc12  as oc12
  , le.squat1
  , le.squat2
  , le.squat3
  , le.squat4

  , le.bench1
  , le.bench2
  , le.bench3
  , le.bench4

  , le.dl1
  , le.dl2
  , le.dl3
  , le.dl4


  , cast(le.summaall as numeric(6,2)) as "Total"
  , cast(le.summaall * w.coef as numeric(6,4)) as "G.Points"

from lifter_on_competition loc
  inner join lifter_exersis le on loc.id_lifter_compet=le.id_lifter_compet
  inner join lifter l on l.id_lifter = loc.id_lifter
  inner join age_class ac on ac.id_agecl = loc.id_agecl
  inner join wilks w  on w.id_wilks = loc.id_wilks
  inner join weigth_category  wc on wc.id_category = loc.id_category
  inner join team t on t.id_team = loc.id_team
  inner join competit co on co.id_compet = loc.id_compet
  inner join Range r on r.id_range = co.id_range

where co.id_compet = :idc and id_stream = :ids
order by  l.sex, ac.from_age,  wc.we, le.summaall desc,  w.self_weight; 
