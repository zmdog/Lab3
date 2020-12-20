#include <iostream>
#include "windows.h"
#include <stdio.h>
#include <locale>
#include "ConsoleApplication1.h"



using namespace std;

void setCursorPosition(int x, int y)
{
    static const HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
    std::cout.flush();
    COORD coord = { (SHORT)x, (SHORT)y };
    SetConsoleCursorPosition(hOut, coord);
}
void fill(int* (p), int* (e), const int DEGREE) {
    int hight = 0, count = 0, countD = 0, color = 14;
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

    while (true && p <= e + DEGREE - 1) {

        if (p > e - DEGREE * DEGREE / 2 + DEGREE) {
             if (p == e - DEGREE * DEGREE + DEGREE + (DEGREE / 2 - 1) + (DEGREE / 2) * countD) {
                            
                 if (color == 3) color = 13; else color = 3;
                 count++;
                 countD++;
             }
             else {
                 SetConsoleTextAttribute(hConsole, (WORD)((0 << 4) | color));
                 count = -1;
             }
        }
        else if (p == e - DEGREE * DEGREE / 2 + DEGREE) { color = 3; SetConsoleTextAttribute(hConsole, (WORD)((0 << 4) | color)); }
        else {
            if (p == e - DEGREE * DEGREE + DEGREE + (DEGREE / 2 - 1) + (DEGREE / 2) * countD) {

                                
                if (color == 14) color = 7; else color = 14;
                count++;
                countD++;
            }
            else {
                SetConsoleTextAttribute(hConsole, (WORD)((0 << 4) | color));
                count = -1;
            }
        }
        
        if (p != e - DEGREE * DEGREE + DEGREE * 2 - 1 + hight) {

            cout << *p << "\t";
            p += 1;
        }
        else {

            cout << *p << "\t";
            p += 1;
            hight += DEGREE;
            cout << endl;
        }
        count++;
    }
    SetConsoleTextAttribute(hConsole, (WORD)((0 << 4) | 15));
}
void shellFill(int* (p), int* (e), int* (pp), int* (ee), const int DEGREE) {
    int count = 0, * border = e + DEGREE - 1, * d = p, step = DEGREE - 1;

    while (p <= e + DEGREE - 1) {

        *p = 0;
        p += 1;
    }
    p -= DEGREE * DEGREE;

    while (true) {
        system("cls");
        while (p != e - DEGREE * DEGREE / 2 + DEGREE + DEGREE / 2 - 1) {

            if (p == e - DEGREE * (DEGREE - 1) + DEGREE * count + step || p == e + step) {

                *p = abs(1 + rand() % (DEGREE * DEGREE));
                *pp = *p;
                if (p == border) {

                    if (step / abs(step) != 1) {
                        // после прохода вверх
                        count += 1;
                        border = e - count * DEGREE + (DEGREE - count - 1);
                        step = DEGREE - (count + 1);
                        p += 1;
                        pp++;

                    }
                    else {
                        // после прохода вниз
                        if (count == 0) {
                            border = e - DEGREE * (DEGREE - 2);
                        }
                        else {
                            border = e - DEGREE * (DEGREE - 2) + DEGREE * count + count;
                        }

                        p -= 1;
                        pp--;
                        if (step == 35) step = 0; else step = 0 - DEGREE * count + count;
                    }
                }
                else {
                    // Подъем
                    if (step == 0 || step / abs(step) != 1) {

                        step -= DEGREE;
                        p -= DEGREE;
                        pp -= DEGREE;
                    }
                    //Спуск
                    else {

                        step += DEGREE;
                        p += DEGREE;
                        pp += DEGREE;
                    }
                }
            }

            else if (p < e - DEGREE * DEGREE / 2 + DEGREE + DEGREE / 2 - 1) {

                *p = abs(1 + rand() % (DEGREE * DEGREE));
                *pp = *p;
                p += 1;
                pp++;

            }
            else if (p > e - DEGREE * DEGREE / 2 + DEGREE + DEGREE / 2 - 1) {

                *p = abs(1 + rand() % (DEGREE * DEGREE));
                *pp = *p;
                p -= 1;
                pp--;
            }
            fill(d, e, DEGREE);
            Sleep(50);
            setCursorPosition(0, 0);
            if (p == e - DEGREE * DEGREE / 2 + DEGREE + DEGREE / 2 - 1) {
                *p = abs(1 + rand() % (DEGREE * DEGREE));
                *pp = *p;
            }
        }
        fill(d, e, DEGREE);
        break;
    }

}
void snakeFill(int* (p), int* (e), int* (pp), int* (ee), const int DEGREE) {
    int count = 0, * border = e, * d = p, step = DEGREE;

    while (p <= e + DEGREE - 1) {

        *p = 0;
        p += 1;
    }
    p -= DEGREE * DEGREE;

    while (true) {
        system("cls");
        while (p != d + DEGREE - 1) {
            if (step / abs(step) == 1) {
                if (p != border) {
                    *p = abs(1 + rand() % (DEGREE * DEGREE));
                    *pp = *p;
                    p += step;  // сложение
                    pp += step;
                }
                else {
                    *p = abs(1 + rand() % (DEGREE * DEGREE)); // нижняя прорисовка
                    *pp = *p;
                    count += 1;
                    border = d + count;
                    step = -DEGREE;
                    pp++;
                    p += 1;
                }
            }
            else {
                if (p != border) {
                    *p = abs(1 + rand() % (DEGREE * DEGREE));
                    *pp = *p;
                    pp += step;
                    p += step; // вычитание
                }
                else {
                    *p = abs(1 + rand() % (DEGREE * DEGREE)); // верхяя прорисовка
                    *pp = *p;
                    count += 1;
                    border = e + count;
                    step = DEGREE;
                    pp++;
                    p += 1;
                }
            }
            
            fill(d, e, DEGREE);
            Sleep(50);
            setCursorPosition(0, 0);
        }
        *p = abs(1 + rand() % (DEGREE * DEGREE));
        *pp = *p;
        fill(d, e, DEGREE);
        break;
    }
}
void clockWise(const int DEGREE, int* p, int* e, int* pp, int* ee) {
    int* dd = pp, * d = p, * border = e - DEGREE * DEGREE / 2 + DEGREE / 2 - 1;
    int count = 0, circle = 1;

    pp = dd + DEGREE / 2;

    while (true) {

        while (circle != 0) {

            if (count != DEGREE / 2 - 1) {

                *pp = *p;
                pp++;
                p++;
                count++;
            }
            else {
                *pp = *p;
                if (p != border) {

                    count = 0;
                    pp += DEGREE / 2 + 1;
                    p += DEGREE / 2 + 1;
                }
                else {

                    if (circle == 1) {
                        // из первого во второй
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE / 2;
                        pp = dd + DEGREE * DEGREE / 2 + DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 2) {
                        // из второго в четвертый
                        *pp = *p;
                        border += DEGREE * DEGREE / 2;
                        p = d + DEGREE * DEGREE / 2 + DEGREE / 2;
                        pp = dd + DEGREE * DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 3) {
                        // из четвертого в третий
                        *pp = *p;
                        border -= DEGREE / 2;
                        p = d + DEGREE * DEGREE / 2;
                        pp = dd;
                        circle++;
                        count = 0;
                    }
                    else {
                        // из третьего в первый
                        *pp = *p;
                        border -= DEGREE * DEGREE / 2;
                        p = d;
                        pp = dd + DEGREE / 2;
                        circle = 0;
                        count = 0;
                    }
                }
            }
        }
        pp = dd;
        p = d;
        while (pp <= ee) {
            *p = *pp;
            pp++;
            p++;
        }
        fill(dd, ee, DEGREE);
        break;
    }
}
void crissCross(const int DEGREE, int* p, int* e, int* pp, int* ee) {
    int* dd = pp, * d = p, * border = e - DEGREE * DEGREE / 2 + DEGREE / 2 - 1;
    int count = 0, circle = 1;

    pp = dd + DEGREE * DEGREE / 2 + DEGREE / 2;

    while (true) {

        while (circle != 0) {

            if (count != DEGREE / 2 - 1) {

                *pp = *p;
                pp++;
                p++;
                count++;
            }
            else {
                *pp = *p;
                if (p != border) {

                    count = 0;
                    pp += DEGREE / 2 + 1;
                    p += DEGREE / 2 + 1;
                }
                else {
                    
                    if (circle == 1) {
                        // из второго в третий
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE / 2;
                        pp = dd + DEGREE * DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 2) {
                        // из третьего во второй
                        *pp = *p;
                        border = d + DEGREE * DEGREE - DEGREE / 2 - 1;
                        p = d + DEGREE * DEGREE / 2;
                        pp = dd + DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 3) {
                        // из четвертого в первый
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE * DEGREE / 2 + DEGREE / 2;
                        pp = dd;
                        circle++;
                        count = 0;
                        
                    }else{ circle = 0; }
                }
            }
        }
        pp = dd;
        p = d;
        while (pp <= ee) {
            *p = *pp;
            pp++;
            p++;
        }
        fill(dd, ee, DEGREE);
        break;
    }
}
void verticaSwap(const int DEGREE, int* p, int* e, int* pp, int* ee) {
    int* dd = pp, * d = p, * border = e - DEGREE * DEGREE / 2 + DEGREE / 2 - 1;
    int count = 0, circle = 1;

    pp = dd + DEGREE * DEGREE / 2;

    while (true) {

        while (circle != 0) {

            if (count != DEGREE / 2 - 1) {

                *pp = *p;
                pp++;
                p++;
                count++;
            }
            else {
                *pp = *p;
                if (p != border) {

                    count = 0;
                    pp += DEGREE / 2 + 1;
                    p += DEGREE / 2 + 1;
                }
                else {

                    if (circle == 1) {
                        // из второго в четвертый
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE / 2;
                        pp = dd + DEGREE * DEGREE / 2 + DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 2) {
                        // из третьего в первый
                        *pp = *p;
                        border = e + DEGREE / 2 - 1;
                        p = d + DEGREE * DEGREE / 2;
                        pp = dd;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 3) {
                        // из четвертого в первый
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE * DEGREE / 2 + DEGREE / 2;
                        pp = dd + DEGREE / 2;
                        circle++;
                        count = 0;

                    }
                    else { circle = 0; }
                }
            }
        }
        pp = dd;
        p = d;
        while (pp <= ee) {
            *p = *pp;
            pp++;
            p++;
        }
        fill(dd, ee, DEGREE);
        break;
    }


}
void horizontalSwap(const int DEGREE, int* p, int* e, int* pp, int* ee) {
    int* dd = pp, * d = p, * border = d + DEGREE * DEGREE / 2 - DEGREE / 2 - 1;
    int count = 0, circle = 1;

    pp = dd + DEGREE / 2;

    while (true) {

        while (circle != 0) {

            if (count != DEGREE / 2 - 1) {

                *pp = *p;
                pp++;
                p++;
                count++;
            }
            else {
                *pp = *p;
                if (p != border) {

                    count = 0;
                    pp += DEGREE / 2 + 1;
                    p += DEGREE / 2 + 1;
                }
                else {

                    if (circle == 1) {
                        // из второго в первый
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE / 2;
                        pp = dd;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 2) {
                        // из третьего в четвертый
                        *pp = *p;
                        border = e + DEGREE / 2 - 1;
                        p = d + DEGREE * DEGREE / 2;
                        pp = dd + DEGREE * DEGREE / 2 + DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else if (circle == 3) {
                        // из четвертого в третий
                        *pp = *p;
                        border += DEGREE / 2;
                        p = d + DEGREE * DEGREE / 2 + DEGREE / 2;
                        pp = dd + DEGREE * DEGREE / 2;
                        circle++;
                        count = 0;
                    }
                    else { circle = 0; }
                }
            }
        }
        pp = dd;
        p = d;
        while (pp <= ee) {
            *p = *pp;
            pp++;
            p++;
        }
        fill(dd, ee, DEGREE);
        break;
    }
}
void insertSort(int* p, int* e, const int DEGREE) {
    int* d = p, * ee = e;
    for (p; p <= d + DEGREE * DEGREE - 1; p++) {
        for (ee = p; ee > d; ee--) {
            if (*ee < *(ee - 1)) swap(*ee, *(ee - 1));
        }
    }

    fill(d, e, DEGREE);
}
void calculator(int* p, int* e, int* pp, int* ee) {
    char action;
    int numb, *d = p;
    cout << "Выберите опаерацию (+, -, *, /)\n" << endl;
    cin >> action;
    cout << "Введите число\n" << endl;
    cin >> numb;
    while(p <= e) {
        switch (action) {
        case  '+': {
            *p += numb;
            break;
        }
        case  '-': {
            *p -= numb;
            break;
        }
        case  '*': {
            *p *= numb;
            break;
        }
        case  '/': {
            *p /= numb;
            break;
        }
        }
        p++;
    }
    p = d;
    while (pp <= ee) {
        *pp = *p;
        pp++;
        p++;
    }
}
int selectOption(int option, int deep, int* p, int* e, int* pp, int* ee, int degree) {
    auto coutDegree = "\nСоздать массив и отобразить его ввиде квадратичной матрицы\n1. Из 6^2 элементов\n2. Из 8^2 элементов\n3. Из 10^2 элементов\n\n";
    auto coutFill = "\n1. Заполнить Ракушкой\n2. Заполнить змейкой\n";
    auto coutSwap = "\n1. Замена по часовой стрелке\n2. Замена крест-накрест\n3. Вертикальная замена\n4. Горизонтальная замена\n5. Отсортировать\n6. Операция над элементами массива";
    
    switch (option) {
    case 1: {
        if (deep == 1) {
            // степень матрицы
            int arrF[6][6], arrS[6][6], option, degree = 6;
            int* p = arrF[0], * e = arrF[5];
            int* pp = arrS[0], * ee = arrS[5];
            cout << coutFill << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 2, p, e, pp, ee, degree);
        }
        // метод заполнения
        else if (deep == 2) {
            shellFill(p, e, pp, ee, degree);
            cout << coutSwap << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 3, p, e, pp, ee, degree);
        }
        else if (deep == 3) {
            clockWise(degree, p, e, pp, ee);
            cout << "\n1. Отсортировать\n2. Пересоздать массив\n3. Операция над элементами массива" << endl;
            cin >> option;
            selectOption(option, 4, p, e, pp, ee, degree);
        }
        else if(deep == 4){
            insertSort(p, e, degree);
            cout << coutSwap << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 3, p, e, pp, ee, degree);
        }
        break;
    }
    case 2: {
        if (deep == 1) {
            int arrF[8][8], arrS[8][8], option, degree = 8;
            int* p = arrF[0], * e = arrF[8 - 1];
            int* pp = arrS[0], * ee = arrS[7];
            cout << coutFill << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 2, p, e, pp, ee, degree);
        }
        else if (deep == 2) {
            snakeFill(p, e, pp, ee, degree);
            cout << coutSwap << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 3, p, e, pp, ee, degree);
        }
        else if (deep == 3) {
            crissCross(degree, p, e, pp, ee);
            cout << "\n1. Отсортировать\n2. Пересоздать массив\n3. Операция над элементами массива" << endl;
            cin >> option;
            selectOption(option, 4, p, e, pp, ee, degree);
        }
        else if (deep == 4) {
            cout << coutDegree << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 1, 0, 0, 0, 0, 0);
        }
        break;
    }
    case 3: {
        if (deep == 1) {
            int arrF[10][10], arrS[10][10], option, degree = 10;
            int* p = arrF[0], * e = arrF[10 - 1];
            int* pp = arrS[0], * ee = arrS[9];
            cout << coutFill << "\nВыберите действие\n" << endl;
            cin >> option;
            selectOption(option, 2, p, e, pp, ee, degree);
        }
        else if (deep == 3) {
            verticaSwap(degree, p, e, pp, ee);
            cout << "\n1. Отсортировать\n2. Пересоздать массив\n3. Операция над элементами массива" << endl;
            cin >> option;
            selectOption(option, 4, p, e, pp, ee, degree);
        }
        else if (deep == 4) {
            calculator(pp, (ee + degree - 1), p, (e + degree - 1));
            fill(pp, ee, degree);
            cout << coutSwap << endl;
            cin >> option;
            selectOption(option, 3, p, e, pp, ee, degree);
        }
        
        break;
    }
    case 4: {
        if (deep == 3) {
            horizontalSwap(degree, p, e, pp, ee);
            cout << "\n1. Отсортировать\n2. Пересоздать массив\n3. Операция над элементами массива" << endl;
            cin >> option;
            selectOption(option, 4, p, e, pp, ee, degree);
        }
    }
    case 5: {
        insertSort(p, e, degree);
        cout << coutSwap << endl;
        cin >> option;
        selectOption(option, 3, p, e, pp, ee, degree);
    }
    case 6: {
        calculator(p, (e + degree - 1), pp, (ee + degree - 1));
        fill(p, e, degree);
        cout << coutSwap << endl;
        cin >> option;
        selectOption(option, 3, p, e, pp, ee, degree);
    }
    }
    return 0;
}


int main() {
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);

    cout << "\nСоздать массив и отобразить его ввиде квадратичной матрицы\n1. Из 6^2 элементов\n2. Из 8^2 элементов\n3. Из 10^2 элементов\n\n" << endl;
    do {
        int option;
        cout << "\nВыберите действие\n" << endl;
        cin >> option;
        selectOption(option, 1,0,0,0,0,0);
    } while (true);
    return 0;
}
