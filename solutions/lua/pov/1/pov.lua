-- for my Shree DR.MDD
local key_name = 1
local key_children = 2

local function find_lineage(target, node)
  if target == node[key_name] then return { node } end

  for _, kid in ipairs(node[key_children] or {}) do
    local lineage = find_lineage(target, kid)
    if lineage then
      table.insert(lineage, 1, node)
      return lineage
    end
  end
end

local function attach_child(parent, kid)
  parent[key_children] = parent[key_children] or {}
  table.insert(parent[key_children], kid)
end

local function detach_child(parent, target_child)
  for i, kid in ipairs(parent[key_children]) do
    if target_child == kid then
      table.remove(parent[key_children], i)
      if #parent[key_children] == 0 then parent[key_children] = nil end
    end
  end
end

local function deep_clone(node)
  local copy = {}
  for k, v in pairs(node) do
    if type(v) == 'table' then
      copy[k] = deep_clone(v)
    else
      copy[k] = v
    end
  end
  return copy
end

local function pov_from(node_label)
  return {
    of = function(tree)
      tree = deep_clone(tree)
      local lineage = find_lineage(node_label, tree)
      for i = 1, #lineage - 1 do
        detach_child(lineage[i], lineage[i + 1])
        attach_child(lineage[i + 1], lineage[i])
      end
      return lineage[#lineage]
    end
  }
end

local function path_from(start_label)
  return {
    to = function(end_label)
      return {
        of = function(tree)
          local lineage = find_lineage(end_label, pov_from(start_label).of(tree))
          local route = {}
          for _, node in ipairs(lineage) do
            table.insert(route, node[key_name])
          end
          return route
        end
      }
    end
  }
end

return {
  pov_from = pov_from,
  path_from = path_from
}
