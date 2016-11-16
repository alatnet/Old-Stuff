function calculate_elasticity(type,...)
  local __DQ = 0
  local __DP = 0
  local __E = 0
  local __Q = 0
  local __Q1 = 0
  local __P = 0
  local __P1 = 0
  local __SQ = 0
  local __SP = 0
  local __PerQ = 0
  local __PerP = 0

  if type==1 then --arguments: Q, Q1, P, and P1
    __Q = tonumber(arg[1])
    __Q1 = tonumber(arg[2])
    __P = tonumber(arg[3])
    __P1 = tonumber(arg[4])

    __DQ = __Q - __Q1
    if __DQ < 0 then __DQ = __DQ * -1 end

    __DP = __P - __P1
    if __DP < 0 then __DP = __DP * -1 end

    __SQ = (__Q+__Q1)/2
    __SP = (__P+__P1)/2

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DQ,__DP,__PerQ,__PerP,__SQ,__SP,__E
  elseif type==2 then --arguments: DQ and DP, Q, Q1, P, and P1
    __DQ = tonumber(arg[1])
    __DP = tonumber(arg[2])
    __Q = tonumber(arg[3])
    __Q1 = tonumber(arg[4])
    __P = tonumber(arg[5])
    __P1 = tonumber(arg[6])

    __SQ = (__Q+__Q1)/2
    __SP = (__P+__P1)/2

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __PerQ,__PerP,__SQ,__SP,__E
  elseif type==3 then --arguments: DQ, Q, Q1, P, and P1
    __DQ = tonumber(arg[1])
    __Q = tonumber(arg[2])
    __Q1 = tonumber(arg[3])
    __P = tonumber(arg[4])
    __P1 = tonumber(arg[5])

    __DP = __P - __P1
    if __DP < 0 then __DP = __DP * -1 end

    __SQ = (__Q+__Q1)/2
    __SP = (__P+__P1)/2

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DP,__PerQ,__PerP,__SQ,__SP,__E
  elseif type==4 then --arguments: Q, Q1, P, P1, and DP
    __Q = tonumber(arg[1])
    __Q1 = tonumber(arg[2])
    __P = tonumber(arg[3])
    __P1 = tonumber(arg[4])
    __DP = tonumber(arg[5])

    __DQ = __Q - __Q1
    if __DQ < 0 then __DQ = __DQ * -1 end

    __SQ = (__Q+__Q1)/2
    __SP = (__P+__P1)/2

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DQ,__PerQ,__PerP,__SQ,__SP,__E
  elseif type==5 then --arguments: PerQ and PerP
    __PerQ = tonumber(arg[1])
    __PerP = tonumber(arg[2])

    __E = __PerQ/__PerP

    return __E
  elseif type==6 then --arguments: PerQ, P, and P1
    __PerQ = tonumber(arg[1])
    __P = tonumber(arg[2])
    __P1 = tonumber(arg[3])

    __DP = __P - __P1
    if __DP < 0 then __DP = __DP * -1 end

    __SP = (__P+__P1)/2

    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DP,__PerP,__SP,__E
  elseif type==7 then --arguments: Q, Q1, and PerP
    __Q = tonumber(arg[1])
    __Q1 = tonumber(arg[2])
    __PerP = tonumber(arg[3])

    __DQ = __Q - __Q1
    if __DQ < 0 then __DQ = __DQ * -1 end

    __SQ = (__Q+__Q1)/2

    __PerQ = (__DQ/__SQ)

    __E = __PerQ/__PerP

    return __DQ,__PerQ,__SQ,__E
  elseif type==8 then --arguments: PerQ, DP, P, and P1
    __PerQ = tonumber(arg[1])
    __DP = tonumber(arg[2])
    __P = tonumber(arg[3])
    __P1 = tonumber(arg[4])

    __SP = (__P+__P1)/2

    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __PerP,__SP,__E
  elseif type==9 then --arguments: DQ, Q, Q1, and PerP
    __DQ = tonumber(arg[1])
    __Q = tonumber(arg[2])
    __Q1 = tonumber(arg[3])
    __PerP = tonumber(arg[4])

    __SQ = (__Q+__Q1)/2

    __PerQ = (__DQ/__SQ)

    __E = __PerQ/__PerP

    return __PerQ,__SQ,__E
  elseif type==10 then --arguments: DQ, P, P1, SQ, and SP
    __DQ = tonumber(arg[1])
    __P = tonumber(arg[2])
    __P1 = tonumber(arg[3])
    __SQ = tonumber(arg[4])
    __SP = tonumber(arg[5])

    __DP = __P - __P1
    if __DP < 0 then __DP = __DP * -1 end

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DP,__PerQ,__PerP,__E
  elseif type==11 then --arguments: Q, Q1, DP, SQ, and SP
    __Q = tonumber(arg[1])
    __Q1 = tonumber(arg[2])
    __DP = tonumber(arg[3])
    __SQ = tonumber(arg[4])
    __SP = tonumber(arg[5])

    __DQ = __Q - __Q1
    if __DQ < 0 then __DQ = __DQ * -1 end

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DQ,__PerQ,__PerP,__E
  elseif type==12 then --arguments: DQ, DP, SQ, and SP
    __DQ = tonumber(arg[1])
    __DP = tonumber(arg[2])
    __SQ = tonumber(arg[3])
    __SP = tonumber(arg[4])

    __PerQ = (__DQ/__SQ)
    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __PerQ,__PerP,__E
  elseif type==13 then --arguments: PerQ, P, P1, and SP
    __PerQ = tonumber(arg[1])
    __P = tonumber(arg[2])
    __P1 = tonumber(arg[3])
    __SP = tonumber(arg[4])

    __DP = __P - __P1
    if __DP < 0 then __DP = __DP * -1 end

    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __DP,__PerP,__E
  elseif type==14 then --arguments: Q, Q1, PerP, and SQ
    __Q = tonumber(arg[1])
    __Q1 = tonumber(arg[2])
    __PerP = tonumber(arg[3])
    __SQ = tonumber(arg[4])

    __DQ = __Q - __Q1
    if __DQ < 0 then __DQ = __DQ * -1 end

    __PerQ = (__DQ/__SQ)

    __E = __PerQ/__PerP

    return __DQ,__PerQ,__SQ,__E
  elseif type==15 then --arguments: DQ, SQ, and PerP
    __DQ = tonumber(arg[1])
    __SQ = tonumber(arg[2])
    __PerP = tonumber(arg[3])

    __PerQ = (__DQ/__SQ)

    __E = __PerQ/__PerP

    return __PerQ,__E
  elseif type==16 then --arguments: PerQ, DP, and SP
    __PerQ = tonumber(arg[1])
    __DP = tonumber(arg[2])
    __SP = tonumber(arg[3])

    __PerP = (__DP/__SP)

    __E = __PerQ/__PerP

    return __PerP,__E
  end
end