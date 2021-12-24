#include <bits/stdc++.h>

#define for_number(start, end) for (auto i = start; i < end; i++)
#define for_iter(a, vect) for (a : vect)
#define for_iter_const(mapa) for (auto const &a : mapa)

#define MP(x, y) make_pair(x, y)
#define PB(x) push_back(x)
#define F first
#define S second
#define endl "\n"
#define fast                 \
    ios::sync_with_stdio(0); \
    cin.tie(0);              \
    cout.tie(0);

using namespace std;

typedef long long ll;
typedef vector<int> vi;
typedef vector<long long> vll;
typedef pair<int, int> pi;

int main()
{
    fast;
    string value;
    int mina = INT_MAX;

    int hor = 0;
    int depth = 0;

    while (getline(cin, value)) // if value == -1, loop stops.
    {
        string move = "";

        int size;
        string temp = "";

        for (auto x : value)
        {
            if (x == ' ')
            {
                move = temp;
                temp.clear();
            }
            else if (x != '\n')
                temp += x;
        }

        size = stoi(temp);

        if (move == "forward")
            hor += size;
        else if (move == "down")
            depth += size;
        else
            depth -= size;
    }

    cout << depth * hor;
}
