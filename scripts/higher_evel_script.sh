# Number of EVs
set fmri(evs_orig) 26
set fmri(evs_real) 26
set fmri(evs_vox) 0

# Number of contrasts
set fmri(ncon_orig) 26
set fmri(ncon_real) 26

# Number of F-tests
set fmri(nftests_orig) 0
set fmri(nftests_real) 0

# Loop through each EV and input to set the values
foreach EVnum (`count -digits 1 1 26`)
    set fmri(evtitle$EVnum) "EV$EVnum"
    set fmri(shape$EVnum) 2
    set fmri(convolve$EVnum) 0
    set fmri(tempfilt_yn$EVnum) 0
    set fmri(deriv_yn$EVnum) 0
    set fmri(custom$EVnum) "dummy"
    set fmri(ortho$EVnum.0) 0
    set fmri(ortho$EVnum.$EVnum) 0
    
    foreach inputnum (`count -digits 1 1 52`)
        set fmri(evg$EVnum.$inputnum) 0
    end
    set fmri(evg$EVnum.$EVnum) 1
end

# Set group membership for all inputs
foreach inputnum (`count -digits 1 1 52`)
    set fmri(groupmem.$inputnum) 1
end

# Set up contrasts
foreach connum (`count -digits 2 1 26`)
    set fmri(conname$connum) "C$connum"
    set fmri(conpic_real.$connum) 1

    foreach EVnum (`count -digits 1 1 26`)
        set fmri(con_real.$connum.$EVnum) 0
    end
    set fmri(con_real.$connum.$connum) 1
end

