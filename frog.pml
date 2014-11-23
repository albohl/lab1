int stones[7] = {1,1,1,0,2,2,2};


proctype yellowfrog(int index)
{

	jump:

	if

		:: (index == 6 && stones[6] != 3) -> atomic{ stones[6] = 3; goto finish; }

		:: (index == 5 && stones[6] == 3 && stones[5] != 3) -> atomic{ stones[5] = 3; goto finish; }

		:: (index == 4 && stones[5] == 3 && stones[4] != 3) -> atomic{ stones[4] = 3; goto finish; }

		:: (index == 5 && stones[index + 1] == 0) -> atomic{ printf("Frog on stone %d jumped\n", index); stones[index] = 0; stones[index + 1] = 1; index = index + 1;}

		:: (index < 5 && stones[index + 1] == 0) -> atomic{ printf("Frog on stone %d jumped\n", index); stones[index] = 0; stones[index + 1] = 1; index = index + 1; }

		:: (index < 4 && stones[index + 2] == 0 && stones[index + 1] != 1) -> atomic{ printf("Frog on stone %d jumped\n", index); stones[index] = 0; stones[index + 2] = 1; index = index + 2; }

		:: else skip;

		fi

		goto jump;

	finish:

		skip;

}



proctype redfrog(int index)
{

	jump:

		if

		:: (index == 0 && stones[0] != 3) -> atomic{ stones[0] = 3; goto finish; }

		:: (index == 1 && stones[0] == 3 && stones[1] != 3) -> atomic{ stones[1] = 3; goto finish; }

		:: (index == 2 && stones[1] == 3 && stones[2] != 3) -> atomic{ stones[2] = 3; goto finish; }

		:: (index == 1 && stones[index - 1] == 0) -> atomic{ printf("Frog on stone %d jumped\n", index); stones[index] = 0; stones[index - 1] = 2; index = index - 1; }

		:: (index > 1 && stones[index - 1] == 0) -> atomic{ printf("Frog on stone %d jumped\n", index); stones[index] = 0; stones[index - 1] = 2; index = index - 1; }

		:: (index > 2 && stones[index - 2] == 0 && stones[index - 1] != 2) -> atomic{ printf("Frog on stone %d jumped\n", index); stones[index] = 0; stones[index - 2] = 2; index = index - 2; }

		:: else skip;

		fi

		goto jump;

	finish:

		skip;

}



proctype Monitor()

{

	assert(!(stones[2] == 3 && stones[4] == 3));

}



init

{

	run Monitor();

	run yellowfrog(0);

	run yellowfrog(1);

	run yellowfrog(2);

	run redfrog(4);

	run redfrog(5);

	run redfrog(6);

}
