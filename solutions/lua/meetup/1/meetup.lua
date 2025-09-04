-- For my Shree DR.MDD
local day_to_num = {
  Sunday = 1,
  Monday = 2,
  Tuesday = 3,
  Wednesday = 4,
  Thursday = 5,
  Friday = 6,
  Saturday = 7
}

local function collect_days(cfg)
  local target_day = day_to_num[cfg.day]
  local days_list = {}

  for d = 1, math.huge do
    local dt = os.date('*t', os.time({
      year = cfg.year,
      month = cfg.month,
      day = d
    }))

    if dt.month ~= cfg.month then break end

    if dt.wday == target_day then
      table.insert(days_list, d)
    end
  end

  return days_list
end

local function first_teen(days)
  for _, v in ipairs(days) do
    if v > 12 then return v end
  end
end

local function last_day(days)
  return days[#days]
end

local function ordinal_day(days, which)
  return days[({
    first = 1,
    second = 2,
    third = 3,
    fourth = 4
  })[which]]
end

return function(cfg)
  local days_list = collect_days(cfg)

  if cfg.week == 'teenth' then
    return first_teen(days_list)
  elseif cfg.week == 'last' then
    return last_day(days_list)
  else
    return ordinal_day(days_list, cfg.week)
  end
end
