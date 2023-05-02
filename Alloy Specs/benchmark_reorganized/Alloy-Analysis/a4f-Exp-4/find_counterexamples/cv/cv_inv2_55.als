pred inv2 {
        all u : User | u.profile in (Work.:source).(u + Institution)
}