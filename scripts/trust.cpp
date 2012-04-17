/*
 * TEAM NULL (c) 2012
 * compile: g++ trust.cpp -o trust
 *
 * use: ./trust < [FILE]
 *  or: ./trust < [File] > [OUTFILE]
 *
 * input file format example:
 * 4
 * 2.0 3.0 12.1 40.9
 * x 0 0 1
 * 1 x 0 0
 * 0 1 x 0
 * 0 0 1 x
 *
 * first number is number of members.
 * second line shows base trust
 * entries in colum i represent who is truted by member i.
 * in example, 1 trusts 2, 2 trusts 3, 3 trusts 4,
 * and 4 trusts 1. (conversely, entries in row j shows who
 * trusts member j). all members in initial matrix have trust
 * of 1 before algorithm applied.
 *
 * DID NOT USE RELAXATION/GAUSS-SEIDEL.
 *
 * uses recursive propogation of trust through tree, halting
 * propogation after a given tolerance is reached
 *
 * set trust_fraction_given to a desired fraction of rating to
 * give to others when you trust them. IF TRUST FRACTION >= 1
 * ALGORITHM WILL NOT HALT! but this would mean you can give
 * members more trust than you have...doesn't make sense
 *
 * trust given to others depends on your trust, which depends
 * (among other things) on the trust of members that trust you
 */


#include <iostream>
using namespace std;

double tolerance = 0.001; // if no user input desired could make static
double trust_fraction_given = .2; // if no user input desired could make static

struct trust_list_node
{
  trust_list_node *next_trusted_member;
  int member_trusted;
};

struct member
{
  double base_trust;
  //double added_trust;
  double total_trust;
  trust_list_node *next_trusted_member;
  bool has_propogated;
};

void test_structure(member** mem, int length)
{
  for (int i = 0; i < length; i++) {
    cout << "member " << i+1 << " has trust " << mem[i]->total_trust << " and trusts members: ";
    trust_list_node* node = mem[i]->next_trusted_member;
    while (node != NULL) {
      cout << node->member_trusted+1 << " and ";
      node = node->next_trusted_member;
    }
    cout << "(nobody)" << endl;
  }
}

void propogate_trust(member** members, int member_number, double trust_given)
{
  if (trust_given < tolerance) {
    if (trust_given >= tolerance * 0.5) {
      members[member_number]->total_trust = members[member_number]->total_trust + tolerance;
    }
    return;
  }

  members[member_number]->total_trust = members[member_number]->total_trust + trust_given;

  trust_list_node* node = members[member_number]->next_trusted_member;
  while (node != NULL)
  {
    propogate_trust(members, node->member_trusted, trust_given * trust_fraction_given);
    members[node->member_trusted]->has_propogated = true;
    node = node->next_trusted_member;
  }
}

void create_network(member** members, int length)
{
  for(int i = 0; i < length; i++) {
    trust_list_node *node = members[i]->next_trusted_member;
    while(node != NULL) {
      //cout<<"here1."<<i<<endl;
      //if(!members[node->member_trusted]->has_propogated) {
        //cout<<"here2."<<i<<endl;
      propogate_trust(members,
              node->member_trusted,
              members[i]->base_trust * trust_fraction_given);
      node = node->next_trusted_member;
    }
  }
}

int main()
{
  int num_members, ival;
  char garbage;
  double dval;
  cin >> num_members;

  member *members[num_members];
  for (int i = 0; i < num_members; i++) {
    cin >> dval;
    member *new_member = new member;
    new_member->next_trusted_member = NULL;
    new_member->total_trust = new_member->base_trust = dval;
    new_member->has_propogated = false;
    members[i] = new_member;
  }
  for (int i = 0; i < num_members; i++) {
    for (int j = 0; j < num_members; j++) {
      (i == j) ? cin >> garbage : cin >> ival;
      if (i == j) ival = 0;
      if (ival != 0) {
        trust_list_node *new_node = new trust_list_node;
        new_node->member_trusted = i;
        new_node->next_trusted_member = members[j]->next_trusted_member;
        members[j]->next_trusted_member = new_node;
        // members[j]->total_trust = members[j]->base_trust = ival;
      }
    }
  }
  // test_structure((members), num_members);
  create_network((members), num_members);
  test_structure((members), num_members);
  return 0;
}
