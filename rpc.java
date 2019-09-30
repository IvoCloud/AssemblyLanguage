//Ivaylo Ivanov
public class rpc extends Pep8{
    public static void main(String[] args) {
        final String INTRO = "----------------------------------\n" +
                "---Bienvenue au jeu de roche-papier-sciseau---\n" +
                "----------------------------------\n";
        final String NOMBRE_MANCHES = "Combien de manches voulez-vous jouer?";
        final String JOUEUR1 = "JOUEUR 1, quel est votre choix? [r/p/c]";
        final String JOUEUR2 = "JOUEUR 2, quel est votre choix? [r/p/c]";
        final String ERREUR = "Erreur d'entrée! Programme terminé.";

        int n=0;
        int score1=0;
        int score2=0;
        char choix1;
        char choix2;

        stro(INTRO);                    //Messages d'introduction
        stro(NOMBRE_MANCHES);
        n = deci();                     //Saisir nombre de manches

        //Bitwise OR, valider si nombre impair, sinon ajouter 1
        n=n^1;

        //Boucle principale sur n-manches
        do {
            stro("Il reste " + n + " manches a jouer!\n");

            //Soliciter joueur 1
            stro(JOUEUR1);
            choix1 = chari();
            while(choix1 == '\n'){                  //Remplace scanner.nextLine
                choix1 = chari();
            }
            stro("Le choix est " + choix1 + "\n");

            //Validation du char saisie
            if (choix1 != 114 && choix1 != 112 && choix1 != 99) {
                stro(ERREUR);
                stop();
            }

            //Soliciter joueur 1
            stro(JOUEUR2);
            choix2 = chari();
            while(choix2 == '\n'){                  //Remplace scanner.nextLine
                choix2 = chari();
            }

            //Validation du char saisie
            if (choix2 != 114 && choix2 != 112 && choix2 != 99) {
                stro(ERREUR);
                stop();
            }

            /*Evaluer les valeurs choix 1 et choix 2
            pour determiner le gagnant*/
            if (choix1 == choix2) {
                stro("Manche nulle...\n");
                stro("\n");
            } else if (choix1 == 114) {
                if(choix2==112)score2++;
                else score1++;
            }else if(choix1==112){
                if(choix2==114) score1++;
                else score2++;
            }else if(score1==99){
                if(score2==112) score1++;
                else score2++;
            }

            //Reduire n de manches
            n--;
            stro("Score: " + score1 + " " + score2 + "\n");

            /* Valider si la partie est terminee avant le nbr de manches jouees
            et imprimer le gagnant
             Code est aussi valide pour determiner le gagnant si manches == 0
             */
            if((score1-score2)>n) {
                stro("Joueur 1 a gagne! Score final: " + score1 + " " + score2);
                stop();
            }else if((score2-score1)>n) {
                stro("Joueur 2 a gagne! Score final: " + score1 + " " + score2);
                stop();
            }
        }while (n>0);

        //Imprimer si aucun gagnant et match est egal
        stro("Match egal!");


/*        ASCII code:
          r  //114
          p  //112
          c  //99   */
    }
}
