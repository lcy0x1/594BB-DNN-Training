const x_arr = [];
const w_arr = [];
const w2_arr = [];
const w3_arr = [];

const dy_arr = [];

let seed = 1234567;
for (let i = 0; i < 64; i++) {
    for (let j = 0; j < 64; j++) {
        if (!w_arr[i]) w_arr[i] = [];
        if (!x_arr[i]) x_arr[i] = [];
        if (!w2_arr[i]) w2_arr[i] = [];
        if (!w3_arr[i]) w3_arr[i] = [];
        if (!dy_arr[i]) dy_arr[i] = [];
        w_arr[i][j] = seed % 2;
        seed = seed * 17 % 100007;
        x_arr[i][j] = seed % 2;
        seed = seed * 17 % 100007;
        w2_arr[i][j] = seed % 2;
        seed = seed * 17 % 100007;
        w3_arr[i][j] = seed % 2;
        seed = seed * 17 % 100007;
        dy_arr[i][j] = seed % 2;
        seed = seed * 17 % 100007;
    }
}

let str0 = '';
str0 += `mode = 32'h02;\n`;
for (let i1 = 0; i1 < 2; i1++) {
    for (let i0 = 0; i0 < 8; i0++) {
        for (let j = 0; j < 16; j++) {
            str0 += `in_data = ${w_arr[i1 * 8 + i0][j]};\n`;
            str0 += '#(CLK);\n';
        }
    }
}

str0 += `mode = 32'h42;\n`;
for (let i = 0; i < 16; i++) {
    for (let j = 0; j < 16; j++) {
        str0 += `in_data = ${w2_arr[i][j]};\n`;
        str0 += '#(CLK);\n';
    }
}

str0 += `mode = 32'h12;\n`;
for (let i = 0; i < 16; i++) {
    for (let j = 0; j < 16; j++) {
        str0 += `in_data = ${w3_arr[i][j]};\n`;
        str0 += '#(CLK);\n';
    }
}

str0 += `mode = 32'h52;\n`;
for (let i = 0; i < 16; i++) {
    for (let j = 0; j < 16; j++) {
        str0 += `in_data = ${x_arr[i][j]};\n`;
        str0 += '#(CLK);\n';
    }
}


str0 += `mode = 32'h82;\n`;
for (let i = 0; i < 16; i++) {
    for (let j = 0; j < 16; j++) {
        str0 += `in_data = ${dy_arr[i][j]};\n`;
        str0 += '#(CLK);\n';
    }
}


const fs = require('fs');
fs.writeFileSync('gen.txt', str0);