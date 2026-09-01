#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>

char chess_board[10][10] = {
    {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
    {'x', 'R', 'P', '0', '0', '0', '0', 'p', 'r', 'x'},
    {'x', 'N', 'P', '0', '0', '0', '0', 'p', 'n', 'x'},
    {'x', 'B', 'P', '0', '0', '0', '0', 'p', 'b', 'x'},
    {'x', 'Q', 'P', '0', '0', '0', '0', 'p', 'q', 'x'},
    {'x', 'K', 'P', '0', '0', '0', '0', 'p', 'k', 'x'},
    {'x', 'B', 'P', '0', '0', '0', '0', 'p', 'b', 'x'},
    {'x', 'N', 'P', '0', '0', '0', '0', 'p', 'n', 'x'},
    {'x', 'R', 'P', '0', '0', '0', '0', 'p', 'r', 'x'},
    {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'}};
    
int KX = 5, KY = 1; 
int kx = 5, ky = 8;

void findsquare_White(char start_sqre[], char end_sqr[], const char *piece, char curr_move[], bool isCapture, bool isCheck, bool is_check_mate, int spx, int spy)
{

    int x = end_sqr[0] - 'a' + 1;
    int y = end_sqr[1] - '0';

    int i = x, j = y;

    if (piece == "King")
    {
        chess_board[x][y] = 'K';

        i = KX;
        j = KY;
        KX = x;
        KY = y;
    }

    else if (piece == "Pawn")
    {

        if (isCapture)
        {
            i = curr_move[0] - 'a' + 1;
            j = y - 1;
        }
        else
        {
            while (chess_board[i][j] == '0')
            {
                j--;
            }
        }
        chess_board[x][y] = 'P';
    }

    else if (piece == "Rook")
    {

        bool piece_to_find = true;
        chess_board[i][j] = '0';

        while (chess_board[i][j] == '0')
            {
            i++; // right
            }
        if (chess_board[i][j] == 'R')
            {
            piece_to_find = false;
            }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--; // left
            }
            if (chess_board[i][j] == 'R')
            {
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                j--; // bottom
            }
            if (chess_board[i][j] == 'R')
            {
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                j++; // up
            }
            if (chess_board[i][j] == 'R')
            {
                piece_to_find = false;
            }
        }
        chess_board[x][y] = 'R';
        if (spx != 0)
        {
            i = spx;
            j = y;
        }
        if (spy != 0)
        {
            i = x;
            j = spy;
        }
    }

    else if (piece == "Bishop")
    {
        bool piece_to_find = true;
        chess_board[i][j] = '0';

        while (chess_board[i][j] == '0')
        {
            i++;
            j++; 
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
        if (chess_board[i][j] == 'B')
            piece_to_find = false;
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--;
                j++; 
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'B')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i++;
                j--; // right-bottom diagonal
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'B')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--;
                j--; // left-bottom diagonal
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'B')
                piece_to_find = false;
            }
        }
        chess_board[x][y] = 'B';
    }

    else if (piece == "Knight")
    {
        bool piece_to_find = true;
        if (chess_board[(i - 1) % 10][(j - 2) % 10] == 'N' && piece_to_find)
        {
            i = i - 1;
            j = j - 2;
            piece_to_find = false;
        }
        if (chess_board[(i - 1) % 10][(j + 2) % 10] == 'N' && piece_to_find)
        {
            i = i - 1;
            j = j + 2;
            piece_to_find = false;
        }
        if (chess_board[(i + 1) % 10][(j - 2) % 10] == 'N' && piece_to_find)
        {
            i = i + 1;
            j = j - 2;
            piece_to_find = false;
        }
        if (chess_board[(i + 1) % 10][(j + 2) % 10] == 'N' && piece_to_find)
        {
            i = i + 1;
            j = j + 2;
            piece_to_find = false;
        }
        if (chess_board[(i - 2) % 10][(j - 1) % 10] == 'N' && piece_to_find)
        {
            i = i - 2;
            j = j - 1;
            piece_to_find = false;
        }
        if (chess_board[(i - 2) % 10][(j + 1) % 10] == 'N' && piece_to_find)
        {
            i = i - 2;
            j = j + 1;
            piece_to_find = false;
        }

        if (chess_board[(i + 2) % 10][(j - 1) % 10] == 'N' && piece_to_find)
        {
            i = i + 2;
            j = j - 1;
            piece_to_find = false;
        }
        if (chess_board[(i + 2) % 10][(j + 1) % 10] == 'N' && piece_to_find)
        {
            i = i + 2;
            j = j + 1;
            piece_to_find = false;
        }

        if (spx != 0)
        {
            i = spx;
            int d = 3 - abs(x - spx);
            if (chess_board[spx][y + d] == 'N')
            {
                j = y + d;
            }
            if (chess_board[spx][y - d] == 'N')
            {
                j = y - d;
            }
        }
        if (spy != 0)
        {
            j = spy;
            int d = 3 - abs(y - spy);
            if (chess_board[x + d][spy] == 'N')
            {
                i = x + d;
            }
            if (chess_board[x - d][spy] == 'N')
            {
                i = x - d;
            }
        }
        // printf(" c3 i= %d , j = %d\n",i,j);
        chess_board[x][y] = 'N';
    }

    else if (piece == "Queen")
    {
        bool piece_to_find = true;
        chess_board[i][j] = '0';

        while (chess_board[i][j] == '0')
        {
            i++; // right
        }

        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }

            if (piece_to_find)
            {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--; // left
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                j--; // bottom
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                j++; // up
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i++;
                j++; // top-right diagonal
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--;
                j++; // top left diagonal
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i++;
                j--; // right-bottom diagonal
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--;
                j--; // left-bottom diagonal
            }
            if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
            {
                if (chess_board[i][j] == 'Q')
                piece_to_find = false;
            }
        }

        chess_board[x][y] = 'Q';
    }

    chess_board[i][j] = '0';
    start_sqre[0] = i + 'a' - 1;
    start_sqre[1] = '0' + j;
    return;
}

void squreforBlack_st(char start_sqre[], char end_sqr[], const char *piece, char curr_move[], bool isCapture, bool isCheck, bool is_check_mate, int spx, int spy)
{

    int x = end_sqr[0] - 'a' + 1;
    int y = end_sqr[1] - '0';


    int i = x, j = y;

    if (piece == "King")
    {
        chess_board[x][y] = 'k';

        i = kx;
        j = ky;
        kx = x;
        ky = y;
    }

    else if (piece == "Pawn")
    {

        if (isCapture)
        {
            i = curr_move[0] - 'a' + 1;
            j = y + 1;
        }
        else
        {
            while (chess_board[i][j] == '0')
            {
                j++;
            }
        }
        chess_board[x][y] = 'p';
    }

    else if (piece == "Rook")
    {

        bool piece_to_find = true;
        chess_board[i][j] = '0';

        while (chess_board[i][j] == '0')
        {
            i++; 
        }
        if (chess_board[i][j] == 'r')
        {
            piece_to_find = false;
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                i--; // left
            }
            if (chess_board[i][j] == 'r')
            {
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                j--; // bottom
            }
            if (chess_board[i][j] == 'r')
            {
                piece_to_find = false;
            }
        }

        if (piece_to_find)
        {
            i = x;
            j = y;
            while (chess_board[i][j] == '0')
            {
                j++; // up
            }
            if (chess_board[i][j] == 'r')
            {
                piece_to_find = false;
            }
        }
        chess_board[x][y] = 'r';
        if (spx != 0)
        {
            i = spx;
            j = y;
        }
        if (spy != 0)
        {
            i = x;
            j = spy;
        }
    }

    else if (piece == "Bishop")
    {
        bool piece_to_find = true;
        chess_board[i][j] = '0';

        while (chess_board[i][j] == '0')
        {
        i++;
        j++; 
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
        if (chess_board[i][j] == 'b')
            piece_to_find = false;
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i--;
            j++; // top left diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'b')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i++;
            j--; // right-bottom diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'b')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i--;
            j--; // left-bottom diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'b')
            piece_to_find = false;
        }
        }
        chess_board[x][y] = 'b';
    }

    else if (piece == "Knight")
    {
        bool piece_to_find = true;
        if (chess_board[(i - 1) % 10][(j - 2) % 10] == 'n' && piece_to_find)
        {
        i = i - 1;
        j = j - 2;
        piece_to_find = false;
        }
        if (chess_board[(i - 1) % 10][(j + 2) % 10] == 'n' && piece_to_find)
        {
        i = i - 1;
        j = j + 2;
        piece_to_find = false;
        }
        if (chess_board[(i + 1) % 10][(j - 2) % 10] == 'n' && piece_to_find)
        {
        i = i + 1;
        j = j - 2;
        piece_to_find = false;
        }
        if (chess_board[(i + 1) % 10][(j + 2) % 10] == 'n' && piece_to_find)
        {
        i = i + 1;
        j = j + 2;
        piece_to_find = false;
        }
        if (chess_board[(i - 2) % 10][(j - 1) % 10] == 'n' && piece_to_find)
        {
        i = i - 2;
        j = j - 1;
        piece_to_find = false;
        }
        if (chess_board[(i - 2) % 10][(j + 1) % 10] == 'n' && piece_to_find)
        {
        i = i - 2;
        j = j + 1;
        piece_to_find = false;
        }
        if (chess_board[(i + 2) % 10][(j - 1) % 10] == 'n' && piece_to_find)
        {
        i = i + 2;
        j = j - 1;
        piece_to_find = false;
        }
        if (chess_board[(i + 2) % 10][(j + 1) % 10] == 'n' && piece_to_find)
        {
        i = i + 2;
        j = j + 1;
        piece_to_find = false;
        }
        if (spx != 0)
        {
        i = spx;
        int d = 3 - abs(x - spx);
        if (chess_board[spx][y + d] == 'n')
        {
            j = y + d;
        }
        if (chess_board[spx][y - d] == 'n')
        {
            j = y - d;
        }
        }
        if (spy != 0)
        {
        j = spy;
        int d = 3 - abs(y - spy);
        if (chess_board[x + d][spy] == 'n')
        {
            i = x + d;
        }
        if (chess_board[x - d][spy] == 'n')
        {
            i = x - d;
        }
        }

        chess_board[x][y] = 'n';
    }

    else if (piece == "Queen")
    {
        bool piece_to_find = true;
        chess_board[i][j] = '0';

        while (chess_board[i][j] == '0')
        {
        i++; // right
        }

        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
        if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i--; // left
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            j--; // bottom
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            j++; // up
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i++;
            j++; // top-right diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i--;
            j++; // top left diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i++;
            j--; // right-bottom diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        if (piece_to_find)
        {
        i = x;
        j = y;
        while (chess_board[i][j] == '0')
        {
            i--;
            j--; // left-bottom diagonal
        }
        if ((spx == 0 || spx == i) && (spy == 0 || spy == j))
        {
            if (chess_board[i][j] == 'q')
            piece_to_find = false;
        }
        }

        chess_board[x][y] = 'q';
    }

    chess_board[i][j] = '0';
    start_sqre[0] = i + 'a' - 1;
    start_sqre[1] = '0' + j;
    return;
}

int main()
{
    int move_Number = 1;

    /////////////////////////////////////////TASK 2

    FILE *fileptrr = fopen("gukesh-makan.csv", "r");
    FILE *file_output = fopen("gukesh-makan-01.sql", "w");
    if (fileptrr == NULL)
    {
        printf("can't open file");
    }

    int xnew = 45;
    
    while (xnew--)
    {
        char s[1000];
        char curr_move[10];
        fgets(s, 1000, fileptrr);

        char *tok = strtok(s, ",");
        strcpy(curr_move, tok);

        printf("%s\n", curr_move);
        bool isCapture = 0, isCastle = 0, isCheck = 0, is_check_mate = 0 , isPromoted = 0;
        const char *piece;
        char start_sqre[3], end_sqr[3];
        const char *promoted_to;
        start_sqre[2] = '\0';
        end_sqr[2] = '\0';

        if (curr_move[0] == '1' && curr_move[1] == '-' && curr_move[2] == '0')
        {
            printf("White wins!\n");
            break;
        }

        if (curr_move[0] == '0' && curr_move[1] == '-' && curr_move[2] == '1')
        {
            printf("Black wins!\n");
            break;
        }

        if (!strcmp("1/2x/2", curr_move))
        {
            printf("Draw.\n");
            break;
        }

        switch (curr_move[0])
        {
            case 'K':
            piece = "King";
            break;
            case 'Q':
            piece = "Queen";
            break;
            case 'R':
            piece = "Rook";
            break;
            case 'B':
            piece = "Bishop";
            break;
            case 'N':
            piece = "Knight";
            break;
            default:
            piece = "Pawn";
        }

        if (curr_move[1] == '=' || curr_move[2] == '=' || curr_move[3] == '=')
        {
            isPromoted = 1;
        }
        if(isPromoted){
            switch (curr_move[3])
            {
                case 'K':
                promoted_to = "King";
                break;
                case 'Q':
                promoted_to = "Queen";
                break;
                case 'R':
                promoted_to = "Rook";
                break;
                case 'B':
                promoted_to = "Bishop";
                break;
                case 'N':
                promoted_to = "Knight";
                break;
                default:
                promoted_to = "Pawn";
            }
        }
        else {
            promoted_to="NONE";
        }

        if (curr_move[2] == '+' || curr_move[3] == '+' || curr_move[4] == '+')
        {
            isCheck = 1;
        }
        if (curr_move[2] == '#' || curr_move[3] == '#' || curr_move[4] == '#')
        {
            is_check_mate = 1;
        }

        if (curr_move[1] == 'x' || curr_move[2] == 'x')
        {
            isCapture = 1;
        }

        if (curr_move[1] > '0' && curr_move[1] < '9')
        {
            end_sqr[0] = curr_move[0];
            end_sqr[1] = curr_move[1];
            curr_move[2] = '\0';
            curr_move[3] = '\0';
            curr_move[4] = '\0';
        }

        else if (curr_move[2] > '0' && curr_move[2] < '9')
        {
            end_sqr[0] = curr_move[1];
            end_sqr[1] = curr_move[2];
            curr_move[3] = '\0';
            curr_move[4] = '\0';
        }

        char specialcase = curr_move[1];
        int spx = 0, spy = 0;

        if (curr_move[3] > '0' && curr_move[3] < '9')
        {
            end_sqr[0] = curr_move[2];
            end_sqr[1] = curr_move[3];
            if (specialcase > '0' && specialcase < '9')
            {
                spy = specialcase - '0';
            }
            if (specialcase >= 'a' && specialcase < 'i')
            {
                spx = specialcase - 'a' + 1;
            }
        }
        else if (curr_move[3] > '0' && curr_move[3] < '9')
        {
            end_sqr[0] = curr_move[2];
            end_sqr[1] = curr_move[3];

            if (specialcase > '0' && specialcase < '9')
            {
                spy = specialcase - '0';
            }
            if (specialcase >= 'a' && specialcase < 'i')
            {
                spx = specialcase - 'a' + 1;
            }
        }

        if (curr_move[2] == '=')
        {
            piece = "Pawn";
        }

        // castling the move
        if (!strcmp("O-O", curr_move))
        {
            piece = "King";
            isCastle = true;
            start_sqre[0] = 'e';
            start_sqre[1] = '1';
            end_sqr[0] = 'g';
            end_sqr[1] = '1';
            chess_board[5][1] = '0';
            chess_board[8][1] = '0';
            chess_board[7][1] = 'K';
            chess_board[6][1] = 'R';
            KX = 7;
            KY = 1;
        }
        else if (!strcmp("O-O-O", curr_move))
        {
            piece = "King";
            isCastle = true;
            start_sqre[0] = 'e';
            start_sqre[1] = '1';
            end_sqr[0] = 'c';
            end_sqr[1] = '1';
            chess_board[5][1] = '0';
            chess_board[1][1] = '0';
            chess_board[3][1] = 'K';
            chess_board[4][1] = 'R';
            KX = 3;
            KY = 1;
        }

        else
        {
            findsquare_White(start_sqre, end_sqr, piece, curr_move, isCapture, isCheck, is_check_mate, spx, spy);
        }

        if(isCastle){
            fprintf(file_output, "INSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'WHITE','%s','%s','%s',%d,%d,%d,%d,%d,'%s'); \n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate, isPromoted, promoted_to);

            printf("\nINSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromot,Promoted_toed) VALUES (%d,'WHITE','%s','%s','%s',%d,%d,%d,%d,%d,'%s')\n\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate, isPromoted, promoted_to);

            piece = "Rook";
            isCastle = true;
            start_sqre[0] = 'h';
            start_sqre[1] = '1';
            end_sqr[0] = 'f';
            end_sqr[1] = '1';

            fprintf(file_output, "INSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'WHITE','%s','%s','%s',%d,%d,%d,%d,%d,'%s'); \n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate, isPromoted, promoted_to);

            printf("\nINSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromot,Promoted_toed) VALUES (%d,'WHITE','%s','%s','%s',%d,%d,%d,%d,%d,'%s')\n\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate, isPromoted, promoted_to);

            piece = "King";
            isCastle = true;
            start_sqre[0] = 'e';
            start_sqre[1] = '1';
            end_sqr[0] = 'g';
            end_sqr[1] = '1';
            chess_board[5][1] = '0';
            chess_board[8][1] = '0';
            chess_board[7][1] = 'K';
            chess_board[6][1] = 'R';
            KX = 7;
            KY = 1;

            move_Number++;

        }
        else{
            fprintf(file_output, "INSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'WHITE','%s','%s','%s',%d,%d,%d,%d,%d,'%s'); \n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate, isPromoted, promoted_to);

            printf("\nINSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromot,Promoted_toed) VALUES (%d,'WHITE','%s','%s','%s',%d,%d,%d,%d,%d,'%s')\n\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate, isPromoted, promoted_to);
            move_Number++;

        }

        ////////////////////////////for the black 

        tok = strtok(NULL, ",");

        strcpy(curr_move, tok);
        printf("%s", curr_move);

        isCapture = 0;
        isCastle = 0;
        isCheck = 0;
        is_check_mate = 0;
        isPromoted = 0;

        start_sqre[2] = '\0';
        end_sqr[2] = '\0';

        if (curr_move[0] == '1' && curr_move[1] == '-' && curr_move[2] == '0')
        {
            printf("White wins!\n");
            break;
        }

        if (curr_move[0] == '0' && curr_move[1] == '-' && curr_move[2] == '1')
        {
            printf("Black wins!\n");
            break;
        }

        if (!strcmp("1/2x/2", curr_move))
        {
            printf("Draw.\n");
            break;
        }

        switch (curr_move[0])
        {
            case 'K':
            piece = "King";
            break;
            case 'Q':
            piece = "Queen";
            break;
            case 'R':
            piece = "Rook";
            break;
            case 'B':
            piece = "Bishop";
            break;
            case 'N':
            piece = "Knight";
            break;
            default:
            piece = "Pawn";
        }
        if (curr_move[1] == '=' || curr_move[2] == '=' || curr_move[3] == '=')
        {
            isPromoted = 1;
        }
        if(isPromoted){
            switch (curr_move[3])
            {
                case 'K':
                promoted_to = "King";
                break;
                case 'Q':
                promoted_to = "Queen";
                break;
                case 'R':
                promoted_to = "Rook";
                break;
                case 'B':
                promoted_to = "Bishop";
                break;
                case 'N':
                promoted_to = "Knight";
                break;
                default:
                promoted_to = "Pawn";
            }
        }
        else {
            promoted_to="NONE";
        }
        if (curr_move[2] == '+' || curr_move[3] == '+' || curr_move[4] == '+')
        {
            isCheck = true;
        }
        if (curr_move[2] == '#' || curr_move[3] == '#' || curr_move[4] == '#')
        {
        is_check_mate = true;
        }
        if (curr_move[1] == 'x' || curr_move[2] == 'x')
        {
            isCapture = true;
        }
        if (curr_move[1] > '0' && curr_move[1] < '9')
        {
            end_sqr[0] = curr_move[0];
            end_sqr[1] = curr_move[1];
            curr_move[2] = '\0';
            curr_move[3] = '\0';
            curr_move[4] = '\0';
        }
        else if (curr_move[2] > '0' && curr_move[2] < '9')
        {
            end_sqr[0] = curr_move[1];
            end_sqr[1] = curr_move[2];
            curr_move[3] = '\0';
            curr_move[4] = '\0';
        }
        specialcase = curr_move[1];
        spx = 0, spy = 0;

        if (curr_move[3] > '0' && curr_move[3] < '9')
        {
            end_sqr[0] = curr_move[2];
            end_sqr[1] = curr_move[3];
            if (specialcase > '0' && specialcase < '9')
            {
                spy = specialcase - '0';
            }
            if (specialcase >= 'a' && specialcase < 'i')
            {
                spx = specialcase - 'a' + 1;
            }
        }
        else if (curr_move[3] > '0' && curr_move[3] < '9')
        {
            end_sqr[0] = curr_move[2];
            end_sqr[1] = curr_move[3];

        if (specialcase > '0' && specialcase < '9')
        {
            spy = specialcase - '0';
        }
        if (specialcase >= 'a' && specialcase < 'i')
        {
            spx = specialcase - 'a' + 1;
        }
        }

        if (curr_move[2] == '=')
        {
                    piece = "Pawn";
        }

        if (curr_move[0] == 'O' && curr_move[1] == '-' && curr_move[2] == 'O')
        {
            piece = "King";
            isCastle = true;
            start_sqre[0] = 'e';
            start_sqre[1] = '8';
            end_sqr[0] = 'g';
            end_sqr[1] = '8';
            chess_board[5][8] = '0';
            chess_board[8][8] = '0';
            chess_board[7][8] = 'k';
            chess_board[6][8] = 'r';
            kx = 7;
            ky = 8;
        }
        else if (curr_move[0] == 'O' && curr_move[1] == '-' && curr_move[2] == 'O' && curr_move[1] == '-' && curr_move[2] == 'O')
        {
            piece = "King";
            isCastle = true;
            start_sqre[0] = 'e';
            start_sqre[1] = '8';
            end_sqr[0] = 'c';
            end_sqr[1] = '8';

            chess_board[5][8] = '0';
            chess_board[1][8] = '0';
            chess_board[3][8] = 'k';
            chess_board[4][8] = 'r';
            kx = 3;
            ky = 8;
        }

        else
        {
            squreforBlack_st(start_sqre, end_sqr, piece, curr_move, isCapture, isCheck, is_check_mate, spx, spy);
        }

        if(isCastle){
            fprintf(file_output, "INSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'BLACK','%s','%s','%s',%d,%d,%d,%d,%d,'%s');\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate , isPromoted , promoted_to);
            printf("\nINSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'BLACK','%s','%s','%s',%d,%d,%d,%d,%d,'%s') \n\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate , isPromoted , promoted_to);


            piece = "Rook";
            isCastle = true;
            start_sqre[0] = 'h';
            start_sqre[1] = '8';
            end_sqr[0] = 'f';
            end_sqr[1] = '8';

            fprintf(file_output, "INSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'BLACK','%s','%s','%s',%d,%d,%d,%d,%d,'%s');\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate , isPromoted , promoted_to);
            printf("\nINSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'BLACK','%s','%s','%s',%d,%d,%d,%d,%d,'%s') \n\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate , isPromoted , promoted_to);
            move_Number++;

            piece = "King";
            isCastle = true;
            start_sqre[0] = 'e';
            start_sqre[1] = '8';
            end_sqr[0] = 'g';
            end_sqr[1] = '8';
            chess_board[5][8] = '0';
            chess_board[8][8] = '0';
            chess_board[7][8] = 'k';
            chess_board[6][8] = 'r';
            kx = 7;
            ky = 8;

        }
        else{

            fprintf(file_output, "INSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'BLACK','%s','%s','%s',%d,%d,%d,%d,%d,'%s');\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate , isPromoted , promoted_to);
            printf("\nINSERT INTO ChessTable (curr_move_no,player,piece,start_sqre,end_sqr,isCapture,isCastle,isCheck,is_check_mate,isPromoted,Promoted_to) VALUES (%d,'BLACK','%s','%s','%s',%d,%d,%d,%d,%d,'%s') \n\n", move_Number, piece, start_sqre, end_sqr, isCapture, isCastle, isCheck, is_check_mate , isPromoted , promoted_to);
            move_Number++;
        }
    }

    return 0;
}
