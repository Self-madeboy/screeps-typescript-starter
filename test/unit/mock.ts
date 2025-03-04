export const Game: {
  creeps: { [name: string]: any };
  rooms: any;
  spawns: any;
  time: any;
} = {
  creeps: {},
  rooms: [],
  spawns: {},
  time: 12345
};

export const Memory: {
  creeps: { [name: string]: any };
} = {
  creeps: {}
};
// 在 test/unit/mock.ts 中添加
export const OK = 0;
export const ERR_NOT_IN_RANGE = -9;
export const RESOURCE_ENERGY = "energy";
export const STRUCTURE_SPAWN = "spawn";
export const STRUCTURE_EXTENSION = "extension";
