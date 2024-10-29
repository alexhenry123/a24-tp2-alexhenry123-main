################################################################################
# TP2 - Création d'utilisateurs AD en lot
# 420-3T5-EM Automatisation de tâches
# Automne 2024
#
# Étudiant(e): Alex Henry
################################################################################

#TODO ...



#Requires -Module ActiveDirectory

[CmdletBinding()]
Param(
    # TODO Paramètres de votre script ici
    [ValidateScript( { Test-Path $_ } )]
    [Parameter(Mandatory, ValueFromPipeline)][string] $Path
)

Function Write-Log {
    Param(
        # TODO Paramètres de votre fonction de log ici
        [Parameter(Mandatory)][string] $Path_Log
    )
}

#Arrêter le script s'il y a une erreur
$ErrorActionPreference = "Stop"

# Importation CSV et assignations de variables
try {
    $csv = Import-Csv -Path $Path
    foreach ($user in $csv) {
        $prenom = $user.Prenom
        $nom_famille = $user.Nom
        $nom_complet = $prenom + " " + $nom_famille
        $no_empl = $user.NoEmpl
        $admin = $user.Admin
        $nom_user = ($prenom.substring(0,1) + $nom_famille.substring(0,4)).ToLower()
        $description = $user.NoEmpl
        $mdp = $nom_famille.substring(0,2).ToUpper() + $prenom.substring(0,2).ToLower() + $no_empl
    }
}
catch {
    return "Erreur lors de l'importation du CSV"
}

# Splatting des utilisateurs 
try {
    $ADUserSplat = @{
        Name = $nom_user
        SamAccountName = $nom_user
        UserPrincipalName = $nom_user
        GivenName = $prenom
        Surname = $nom_famille
        DisplayName = $nom_complet
        Description = $description
        Path = Get-ADRootDSE.defaultNamingContext
        AccountPassword = $mdp | ConvertTo-SecureString -AsPlainText -Force
        Admin = $admin
        ChangePasswordAtLogon = $true
        Enabled = $true
    }
    New-ADUser $ADUserSplat
}
catch {
    return "Erreur lors de la création de l'utilisateur"
}

# Conditions de création d'utilisateurs

    # Si l'utilisateur est identifié comme étant administrateur, l'ajouter au groupe d'administrateurs du domaine
    
    
 
