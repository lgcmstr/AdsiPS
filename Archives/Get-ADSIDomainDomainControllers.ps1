﻿Function Get-ADSIDomainDomainControllers
{
    [cmdletbinding()]
    PARAM (
        [Alias('RunAs')]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty,

        $DomainName = [System.DirectoryServices.ActiveDirectory.Domain]::GetcurrentDomain()
    )
    PROCESS
    {
        TRY
        {
            IF ($PSBoundParameters['Credential'] -or $PSBoundParameters['DomainName'])
            {
                Write-Verbose -Message '[PROCESS] Credential or FirstName specified'
                $Splatting = @{ }
                IF ($PSBoundParameters['Credential']) { $Splatting.Credential = $Credential }
                IF ($PSBoundParameters['DomainName']) { $Splatting.DomainName = $DomainName }

                (Get-ADSIDomain @splatting).domaincontrollers

            }
            ELSE
            {
                (Get-ADSIDomain).domaincontrollers
            }

        }
        CATCH
        {
            $pscmdlet.ThrowTerminatingError($_)
        }
    }
}