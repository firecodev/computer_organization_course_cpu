# COLAB 4
### 程式說明
INSTRUCTION_FETCH、INSTRUCTION_DECODE、MEMORY 元件分別會在 rst 高電位時，初始 化 instruction、REG(register)、DM(data memory) 的值，並將 PC(program counter) 設為 0。

當 rst 恢復為低電位時，開始運算，並在抵達最後一行指令時將值輸出至七段顯示器。

註: "rst 按鈕"按下為 0，放開為 1，上述指的 rst 為將"rst 按鈕"進行反向處理後的值，以符合設
計。

### 如何控制顯示器
七段顯示器的顯示主要分為兩個部分，分別是欲顯示的位置與欲顯示的 pattern。

#### 欲顯示位置
依序指定每個位數為 0 電位，其餘為 1 電位，並如此重複掃描，以控制目前哪個位置要顯示。

#### 欲顯示 pattern
依據目前顯示的位置計算其對應顯示數字，再將數字轉換為 ABCDEFG 腳位電位 pattern 後輸出。