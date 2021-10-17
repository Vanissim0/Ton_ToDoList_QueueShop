pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract ToDoList {

    int8 public numList = 0;

    struct list {
        string title;
        uint32 timestamp;
        bool done;
    }
    mapping(int8 => list) optional; //почему-то здесь вылетает ошибка при компиляции.


    constructor() public {

        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();

    }

    // Добавление задачи
    function addTitle(string title) public returns (list) {
        list newTarget = list(title, now, false);
        numList++;
        optional[numList] = newTarget;
        return newTarget;
    }
    // Получение количества открытых задач 
    function getNumOfList() public view returns(int8) {
        return numList;
    }
    
    // Получение списка задач
    function getList() public view returns(mapping (int8 => list) ) {
        return optional;
    }

    // Получение описания задачи по ключу
    function getDescription(int8 num) public view returns(list) {
        if (optional.exist(num)) {
            return optional[num];
        }
    }

    // Удаление задачи по ключу
    function delTarget(int8 num) public {
        if (optional.exist(num)) {
            delete optional[num];
        }
    }

    // Отметить задачу как выполненную по ключу
    function noteTarget(int8 num) public {
        if (optional.exists(num)) {
            optional[num].done = true;
        }
    }