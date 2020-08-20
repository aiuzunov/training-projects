#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
#include<cstring>
#include<string>
using namespace std;


struct bukva
{
    int ct, x;
};
bukva bukvi[26];

int n, numUsedLetters,used[26];
bool couples[26][26];

bool compare (bukva a, bukva b)
{
    if (a.ct>b.ct)return true;
    if (a.ct==b.ct)
        if (couples[a.x][b.x])return true;
    return false;

}


int main ()
{
    int i,j,k;

    scanf("%d", &n);
    string s[n];

    for (i=0; i<n; i++)
    {
        cin>>s[i];
        while(s[i].size()>10){
          cout<<"Думите трябва да бъдат по-малко от 10 символа"<<endl;
          cin>>s[i];
        }
        for (j=0; j<s[i].size(); j++){
            used[ int(s[i][j]-'a') ]=1;
          }
    }

    for (i=0; i<26; i++){
        if (used[i])
          numUsedLetters++;
      }

    for (i=0; i<n; i++)
        for (j=i+1; j<n; j++)
        {
            k=0;
            while (s[i][k]==s[j][k] && k<s[i].size() && k<s[j].size())
              k++;

            if (k<s[i].size() && k<s[j].size())
                if (s[i][k]!=s[j][k]){
                    couples[ int(s[i][k]-'a') ][ int(s[j][k]-'a') ]=true;
                }
        }


    for (i=0; i<26; i++)
        for (j=0; j<26; j++){
            if (couples[i][j] && couples[j][i]){

              cout<<"No"<<endl;
              return 0;
            }
        }
    cout<<"Yes"<<endl;



    for (i=0; i<26; i++)
    {
        bukvi[i].x=i;
        for (j=0; j<26; j++)
        {
            if (couples[i][j])bukvi[i].ct++;
        }
    }

    for (i=0; i<numUsedLetters; i++)
    {
        sort(bukvi, bukvi+26, compare);
        if (bukvi[0].ct)
        {
            cout<<char(bukvi[0].x+'a');
            used[ bukvi[0].x ]++;
            bukvi[0].ct=0;
        }
        else break;
    }

    for (i=0; i<26; i++)
        if (used[i]==1)
          cout<<char(i+'a');

    for (i=0; i<26; i++)
        if (!used[i])
          cout<<char(i+'a');

    cout<<endl;

    return 0;
}
