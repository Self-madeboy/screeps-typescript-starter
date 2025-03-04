import { assert } from "chai";
import { Game, Memory } from "./mock";

// 创建一个模拟的 Creep 对象
const mockCreep = (role: string, energy: number = 0) => ({
  memory: { role, working: false, room: 'W1N1' },
  store: {
    getFreeCapacity: () => 50 - energy,
    [RESOURCE_ENERGY]: energy
  },
  room: {
    find: () => [{id: 'source1'}],
    controller: {id: 'controller1'}
  },
  harvest: () => OK,
  transfer: () => OK,
  upgradeController: () => OK,
  moveTo: () => OK
});

describe("Creep behaviors", () => {
  beforeEach(() => {
    // 重置 Game 和 Memory
    global.Game = _.clone(Game);
    global.Memory = _.clone(Memory);
  });

  describe("Harvester", () => {
    it("should harvest when energy not full", () => {
      const creep = mockCreep('harvester');
      runHarvester(creep as any);
      assert.isTrue(creep.store.getFreeCapacity() > 0);
    });

    it("should transfer energy when full", () => {
      const creep = mockCreep('harvester', 50);
      creep.room.find = () => [{
        structureType: STRUCTURE_SPAWN,
        store: { getFreeCapacity: () => 50 }
      }];

      runHarvester(creep as any);
      assert.equal(creep.store[RESOURCE_ENERGY], 50);
    });
  });

  describe("Upgrader", () => {
    it("should switch working state when energy depleted", () => {
      const creep = mockCreep('upgrader');
      creep.memory.working = true;

      runUpgrader(creep as any);
      assert.isFalse(creep.memory.working);
    });

    it("should switch working state when energy full", () => {
      const creep = mockCreep('upgrader', 50);
      creep.memory.working = false;

      runUpgrader(creep as any);
      assert.isTrue(creep.memory.working);
    });

    it("should upgrade controller when working", () => {
      const creep = mockCreep('upgrader', 50);
      creep.memory.working = true;
      let upgradeControllerCalled = false;

      creep.upgradeController = () => {
        upgradeControllerCalled = true;
        return OK;
      };

      runUpgrader(creep as any);
      assert.isTrue(upgradeControllerCalled);
    });
  });
});
