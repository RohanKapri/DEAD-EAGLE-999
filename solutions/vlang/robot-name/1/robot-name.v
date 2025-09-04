module main

import rand

struct RobotStorage {
mut:
  names map[string]bool
}

struct Robot {
mut:
  name string
}

fn create_robot_storage() RobotStorage {
  return RobotStorage {}
}

// A random name is generated in the format of two uppercase letters followed
// by three digits, such as RX837 or BC811.
fn create_robot_name(mut robots RobotStorage) string {
  for {
    mut buffer := []u8 { cap: 5 }
    for _ in 0..2 {
      buffer << u8(rand.u32_in_range(0x41, 0x5b) or { 0x41 })
    }
    for _ in 0..3 {
      buffer << u8(rand.u32_in_range(0x30, 0x3a) or { 0x30 })
    }
    name := buffer.bytestr()
    if name in robots.names {
      continue
    }
    robots.names[name] = true
    return name
  }
  return ''
}

fn create_robot(mut robots RobotStorage) Robot {
  return Robot { name: create_robot_name(mut robots) }
}

fn (mut r Robot) reset(mut robots RobotStorage) {
  r.name = create_robot_name(mut robots)
}