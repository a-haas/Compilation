#include <fifo.h>
#define NVOISINS 8
for (x = 0; x < N; x++) {
	if (M[x] != 0) /* le pixel appartient a un maximum */
	{
		for (k = 0; k < NVOISINS; k += 1) /* parcourt les voisins */
		{ /* si un voisin n’est pas dans la FIFO */
			y = voisin(x, k, rs, N); /* et pas maximum, on le met en FIFO */
			if ((y != -1) && (! IsSet(y, EN_FIFO)) && (M[y] == 0)) {
				FifoPush(FIFO, y);
				Set(y, EN_FIFO);
				if (trace) printf("empile point %d (%d,%d)\n", y, y%rs, y/rs);
			} /* if y ... */
		} /* for k */
	} /* if M */
} /* for x */